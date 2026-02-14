//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import SwiftData
import SwiftUI

@MainActor
@Observable public class UserPreferences {

  public static let shared = UserPreferences()

  private var modelContext: ModelContext?
  private var settings: UserSettings?

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
    didSet { save() }
  }

  private init() {}

  public func configure(with container: ModelContainer) {
    let context = ModelContext(container)
    context.autosaveEnabled = true
    self.modelContext = context
    loadSettings()
  }

  private func loadSettings() {
    guard let modelContext else { return }

    let descriptor = FetchDescriptor<UserSettings>()
    let results = (try? modelContext.fetch(descriptor)) ?? []

    let settings: UserSettings
    if let existing = results.first {
      settings = existing
    } else {
      settings = migrateFromCloudStorage()
      modelContext.insert(settings)
      try? modelContext.save()
    }

    self.settings = settings
    dailyKTarget = settings.dailyKTarget
    setProTimeReminders = settings.setProTimeReminders
    defaultProTimeInterval = settings.defaultProTimeInterval
    defaultProTimeReminderTitle = settings.defaultProTimeReminderTitle
    proTimeReminderId = settings.proTimeReminderId
    recentFoodsLimit = settings.recentFoodsLimit
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
    guard let settings else { return }
    settings.dailyKTarget = dailyKTarget
    settings.setProTimeReminders = setProTimeReminders
    settings.defaultProTimeInterval = defaultProTimeInterval
    settings.defaultProTimeReminderTitle = defaultProTimeReminderTitle
    settings.proTimeReminderId = proTimeReminderId
    settings.recentFoodsLimit = recentFoodsLimit
    try? modelContext?.save()
  }
}
