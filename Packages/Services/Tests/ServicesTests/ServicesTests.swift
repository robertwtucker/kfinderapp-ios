//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
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
