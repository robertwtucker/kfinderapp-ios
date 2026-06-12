//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import SwiftData

// Device-local by design (no CloudKit). Recents reflect inherently
// per-device context — what was looked up on iPad isn't necessarily
// "recent" on iPhone — and keeping recents off CloudKit aligns with
// the storage-split epic's iCloud-cost story. See issue #92.
@Model public class RecentFood: Equatable {
  public var fdcId: Int = 0
  public var name: String = ""
  public var category: String?
  public var dataType: String = ""
  public var vitaminKPer100g: Double?
  public var viewedAt: Date = Date.now

  public init(
    fdcId: Int,
    name: String,
    category: String? = nil,
    dataType: String,
    vitaminKPer100g: Double? = nil,
    viewedAt: Date = .now
  ) {
    self.fdcId = fdcId
    self.name = name
    self.category = category
    self.dataType = dataType
    self.vitaminKPer100g = vitaminKPer100g
    self.viewedAt = viewedAt
  }

  public convenience init(from food: FoodItem, vitaminKPer100g: Double?) {
    self.init(
      fdcId: food.id,
      name: food.name,
      category: food.category,
      dataType: food.dataType,
      vitaminKPer100g: vitaminKPer100g,
      viewedAt: .now
    )
  }
}

#if DEBUG
  extension RecentFood {
    nonisolated(unsafe) public static let samples = [
      RecentFood(
        fdcId: 2_341_130,
        name: "Cheese, Muenster, reduced fat",
        category: "Cheese",
        dataType: "Survey (FNDDS)",
        vitaminKPer100g: 1.5
      ),
      RecentFood(
        fdcId: 2_345_430,
        name: "Fennel bulb, cooked",
        category: "Other vegetables and combinations",
        dataType: "Survey (FNDDS)",
        vitaminKPer100g: 74.1
      )
    ]
  }
#endif
