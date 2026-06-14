//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Models
import SwiftData
import Testing

@testable import Services

// MARK: - ReminderStoreError Tests

@Suite("ReminderStoreError")
struct ReminderStoreErrorTests {

  @Test(
    "all cases have non-nil error descriptions",
    arguments: [
      ReminderStoreError.accessDenied,
      .accessRestricted,
      .failedReadingCalendar,
      .failedReadingReminder,
      .failedRemovingReminder,
      .reminderHasNoDueDate,
      .unknown
    ]
  )
  func errorDescriptions(error: ReminderStoreError) {
    #expect(error.errorDescription != nil)
    #expect(!error.errorDescription!.isEmpty)
  }

  @Test("accessDenied is a LocalizedError")
  func localizedError() {
    let error: Error = ReminderStoreError.accessDenied
    #expect(error.localizedDescription.isEmpty == false)
  }
}

// MARK: - Formatter+DueDate Tests

@Suite("Formatter.dueDateFormatter")
struct DueDateFormatterTests {

  @Test("formats date without time component")
  func noTimeComponent() {
    let formatter = Formatter.dueDateFormatter
    let date = makeDateComponents(
      year: 2024, month: 6, day: 15, hour: 14, minute: 30)
    let result = formatter.string(from: date)
    // Should not contain time-related characters (colon from time)
    // The exact format depends on locale, but it should be a short date
    #expect(!result.isEmpty)
    // Format a second date with same day but different time to verify
    // time is excluded
    let sameDay = makeDateComponents(
      year: 2024, month: 6, day: 15, hour: 8, minute: 0)
    #expect(formatter.string(from: date) == formatter.string(from: sameDay))
  }

  @Test("produces consistent output for same date")
  func consistent() {
    let formatter = Formatter.dueDateFormatter
    let date = makeDateComponents(
      year: 2024, month: 1, day: 1, hour: 0, minute: 0)
    let result1 = formatter.string(from: date)
    let result2 = formatter.string(from: date)
    #expect(result1 == result2)
  }

  private func makeDateComponents(
    year: Int, month: Int, day: Int, hour: Int, minute: Int
  ) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    return Calendar.current.date(from: components)!
  }
}

// MARK: - UserPreferences Tests

@Suite("UserPreferences", .serialized)
@MainActor
struct UserPreferencesTests {

  private func makeContainer() throws -> ModelContainer {
    try ModelContainer(
      for: UserSettings.self, RecentFood.self,
      configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
  }

  private var prefs: UserPreferences { UserPreferences.shared }

  @Test("loads default values when store is empty")
  func loadsDefaults() throws {
    let container = try makeContainer()
    prefs.configure(with: container)

    #expect(prefs.dailyKTarget == 120)
    #expect(prefs.setProTimeReminders == false)
    #expect(prefs.defaultProTimeInterval == 3)
    #expect(prefs.proTimeReminderId == "")
    #expect(prefs.recentFoodsLimit == 5)
  }

  @Test("creates a settings record when store is empty")
  func createsRecord() throws {
    let container = try makeContainer()
    prefs.configure(with: container)

    let results = try container.mainContext.fetch(
      FetchDescriptor<UserSettings>())
    #expect(results.count == 1)
  }

  @Test("loads existing settings from store")
  func loadsExisting() throws {
    let container = try makeContainer()
    let settings = UserSettings()
    settings.dailyKTarget = 200
    settings.setProTimeReminders = true
    settings.defaultProTimeInterval = 6
    settings.recentFoodsLimit = 10
    container.mainContext.insert(settings)
    try container.mainContext.save()

    prefs.configure(with: container)

    #expect(prefs.dailyKTarget == 200)
    #expect(prefs.setProTimeReminders == true)
    #expect(prefs.defaultProTimeInterval == 6)
    #expect(prefs.recentFoodsLimit == 10)
  }

  @Test("persists property changes to store")
  func saveRoundTrip() throws {
    let container = try makeContainer()
    prefs.configure(with: container)

    prefs.dailyKTarget = 90
    prefs.recentFoodsLimit = 3

    let results = try container.mainContext.fetch(
      FetchDescriptor<UserSettings>())
    #expect(results.count == 1)
    #expect(results[0].dailyKTarget == 90)
    #expect(results[0].recentFoodsLimit == 3)
  }

  @Test("deduplicates multiple settings records")
  func deduplicates() throws {
    let container = try makeContainer()
    container.mainContext.insert(UserSettings())
    container.mainContext.insert(UserSettings())
    container.mainContext.insert(UserSettings())
    try container.mainContext.save()

    prefs.configure(with: container)

    let results = try container.mainContext.fetch(
      FetchDescriptor<UserSettings>())
    #expect(results.count == 1)
  }

  @Test("loading does not overwrite stored values with defaults")
  func loadPreservesValues() throws {
    let container = try makeContainer()
    let settings = UserSettings()
    settings.dailyKTarget = 250
    settings.setProTimeReminders = true
    settings.defaultProTimeInterval = 12
    settings.defaultProTimeReminderTitle = "Custom Title"
    settings.proTimeReminderId = "abc-123"
    settings.recentFoodsLimit = 8
    container.mainContext.insert(settings)
    try container.mainContext.save()

    prefs.configure(with: container)

    let results = try container.mainContext.fetch(
      FetchDescriptor<UserSettings>())
    #expect(results.count == 1)
    #expect(results[0].dailyKTarget == 250)
    #expect(results[0].setProTimeReminders == true)
    #expect(results[0].defaultProTimeInterval == 12)
    #expect(results[0].defaultProTimeReminderTitle == "Custom Title")
    #expect(results[0].proTimeReminderId == "abc-123")
    #expect(results[0].recentFoodsLimit == 8)
  }
}
