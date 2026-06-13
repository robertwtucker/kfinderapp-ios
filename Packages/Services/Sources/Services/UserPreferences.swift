//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import OSLog
import SwiftData
import SwiftUI

@MainActor
@Observable public class UserPreferences {

  public static let shared = UserPreferences()

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier ?? "dev.eclectic.KFinder",
    category: "UserPreferences"
  )
  private var modelContext: ModelContext?
  private var settings: UserSettings?
  private var isLoading = false

  public var dailyKTarget: Double = 120 {
    didSet { save() }
  }

  public var setProTimeReminders: Bool = false {
    didSet { save() }
  }

  public var defaultProTimeInterval: Int = 3 {
    didSet { save() }
  }

  public var defaultProTimeReminderTitle: String = String(
    localized: "test.reminder.title"
  ) {
    didSet { save() }
  }

  public var proTimeReminderId: String = "" {
    didSet { save() }
  }

  public var recentFoodsLimit: Int = 5 {
    didSet {
      save()
      if !isLoading {
        enforceRecentFoodsLimit()
      }
    }
  }

  private init() {}

  public func configure(with container: ModelContainer) {
    modelContext = container.mainContext
    observeRemoteChanges()
    loadSettings()
  }

  private func observeRemoteChanges() {
    NotificationCenter.default.addObserver(
      forName: NSNotification.Name.NSPersistentStoreRemoteChange,
      object: nil,
      queue: nil
    ) { [weak self] _ in
      Task { @MainActor [weak self] in
        self?.loadSettings()
      }
    }
  }

  private func loadSettings() {
    guard let modelContext else {
      logger.error("loadSettings called before context was configured")
      return
    }

    let results: [UserSettings]
    do {
      results = try modelContext.fetch(FetchDescriptor<UserSettings>())
      logger.debug("loadSettings: found \(results.count) record(s)")
    } catch {
      logger.error("loadSettings fetch failed: \(error)")
      return
    }

    if results.count > 1 {
      logger.warning("loadSettings: deduplicating \(results.count) settings records")
      for duplicate in results.dropFirst() {
        modelContext.delete(duplicate)
      }
      try? modelContext.save()
    }

    let settings: UserSettings
    if let existing = results.first {
      settings = existing
    } else {
      settings = migrateFromCloudStorage()
      modelContext.insert(settings)
      do {
        try modelContext.save()
        logger.debug("loadSettings: inserted and saved new settings record")
      } catch {
        logger.error("loadSettings initial save failed: \(error)")
      }
    }

    self.settings = settings
    isLoading = true
    defer { isLoading = false }
    dailyKTarget = settings.dailyKTarget
    setProTimeReminders = settings.setProTimeReminders
    defaultProTimeInterval = settings.defaultProTimeInterval
    defaultProTimeReminderTitle = settings.defaultProTimeReminderTitle
    proTimeReminderId = settings.proTimeReminderId
    recentFoodsLimit = settings.recentFoodsLimit

    enforceRecentFoodsLimit()
  }

  private func migrateFromCloudStorage() -> UserSettings {
    let store = NSUbiquitousKeyValueStore.default
    store.synchronize()

    let settings = UserSettings()
    let keys = store.dictionaryRepresentation.keys

    if keys.contains("dailyKTarget") {
      settings.dailyKTarget = store.double(forKey: "dailyKTarget")
    }
    if keys.contains("setProTimeReminders") {
      settings.setProTimeReminders = store.bool(forKey: "setProTimeReminders")
    }
    if keys.contains("defaultProTimeInterval") {
      settings.defaultProTimeInterval = Int(
        store.longLong(forKey: "defaultProTimeInterval"))
    }
    if let title = store.string(forKey: "defaultProTimeReminderTitle"),
      !title.isEmpty {
      settings.defaultProTimeReminderTitle = title
    }
    if let reminderId = store.string(forKey: "proTimeReminderId") {
      settings.proTimeReminderId = reminderId
    }
    if keys.contains("recentFoodsLimit") {
      settings.recentFoodsLimit = Int(
        store.longLong(forKey: "recentFoodsLimit"))
    }

    return settings
  }

  private func save() {
    guard !isLoading, let settings else { return }
    settings.dailyKTarget = dailyKTarget
    settings.setProTimeReminders = setProTimeReminders
    settings.defaultProTimeInterval = defaultProTimeInterval
    settings.defaultProTimeReminderTitle = defaultProTimeReminderTitle
    settings.proTimeReminderId = proTimeReminderId
    settings.recentFoodsLimit = recentFoodsLimit
    do {
      try modelContext?.save()
    } catch {
      logger.error("save failed: \(error)")
    }
  }

  public func enforceRecentFoodsLimit() {
    guard let modelContext else { return }
    UserPreferences.enforceRecentFoodsLimit(
      in: modelContext, limit: recentFoodsLimit, logger: logger)
  }

  // Static so callers (and tests) can prune any `ModelContext` without
  // going through the singleton's configure/observer lifecycle.
  public static func enforceRecentFoodsLimit(
    in modelContext: ModelContext, limit: Int, logger: Logger? = nil
  ) {
    let descriptor = FetchDescriptor<RecentFood>(
      sortBy: [
        .init(\.viewedAt, order: .forward),
        .init(\.fdcId, order: .forward)
      ]
    )
    do {
      let items = try modelContext.fetch(descriptor)
      guard items.count > limit else { return }
      let toDelete = items.prefix(items.count - limit)
      for item in toDelete {
        modelContext.delete(item)
      }
      try? modelContext.save()
      logger?.debug("enforceRecentFoodsLimit: pruned \(toDelete.count) RecentFood record(s) to limit \(limit)")
    } catch {
      logger?.error("enforceRecentFoodsLimit failed: \(error)")
    }
  }
}
