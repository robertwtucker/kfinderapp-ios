//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Models
import OSLog
import SwiftData

public enum RecentFoodMigrator {
  private static let migrationFlagKey = "RecentFoodMigrationCompleted_v1"

  private static let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier ?? "dev.eclectic.KFinder",
    category: "RecentFoodMigrator"
  )

  @MainActor
  public static func migrateIfNeeded(in container: ModelContainer) {
    let defaults = UserDefaults.standard
    guard !defaults.bool(forKey: migrationFlagKey) else { return }

    let context = container.mainContext
    let start = Date.now

    let foodItems: [FoodItem]
    do {
      foodItems = try context.fetch(
        FetchDescriptor<FoodItem>(
          sortBy: [.init(\.updatedAt, order: .reverse)]
        )
      )
    } catch {
      logger.error("migration fetch failed: \(error)")
      return
    }

    guard !foodItems.isEmpty else {
      defaults.set(true, forKey: migrationFlagKey)
      logger.debug("no FoodItem records; marking migration complete")
      return
    }

    let limit = UserPreferences.shared.recentFoodsLimit
    let keep = foodItems.prefix(limit)

    for item in keep {
      let recent = RecentFood(
        fdcId: item.id,
        name: item.name,
        category: item.category,
        dataType: item.dataType,
        vitaminKPer100g: RecentFood.vitaminKPer100g(from: item.nutrients),
        viewedAt: item.updatedAt
      )
      context.insert(recent)
    }

    // Delete ALL FoodItem records, not just the ones past the cap.
    // The relationship rules on FoodItem cascade to FoodNutrient and
    // FoodMeasure, so this also frees the per-nutrient/measure rows
    // that were the bulk of the storage footprint.
    for item in foodItems {
      context.delete(item)
    }

    do {
      try context.save()
    } catch {
      logger.error("migration save failed: \(error)")
      return
    }

    defaults.set(true, forKey: migrationFlagKey)
    let elapsedMs = Int(Date.now.timeIntervalSince(start) * 1000)
    logger.debug(
      "migrated \(keep.count) of \(foodItems.count) FoodItem record(s) to RecentFood in \(elapsedMs) ms"
    )
  }
}
