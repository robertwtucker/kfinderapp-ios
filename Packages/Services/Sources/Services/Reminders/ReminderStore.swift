//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

@preconcurrency import EventKit
import Models
import SwiftUI

@MainActor public class ReminderStore {
  let eventStore = EKEventStore()

  func isFullAccessAvailable() -> Bool {
    EKEventStore.authorizationStatus(for: .reminder) == .fullAccess
  }

  func verifyAuthorizationStatus() async throws -> Bool {
    let status = EKEventStore.authorizationStatus(for: .reminder)
    switch status {
    case .fullAccess:
      return true
    case .notDetermined:
      return try await eventStore.requestFullAccessToReminders()
    case .denied, .writeOnly:
      throw ReminderStoreError.accessDenied
    case .restricted:
      throw ReminderStoreError.accessRestricted
    @unknown default:
      throw ReminderStoreError.unknown
    }
  }

  func fetch(with id: String) throws -> Reminder? {
    guard isFullAccessAvailable() else {
      throw ReminderStoreError.accessDenied
    }
    guard
      let ekReminder = eventStore.calendarItem(withIdentifier: id)
        as? EKReminder
    else {
      return nil
    }
    return try Reminder(with: ekReminder)
  }

  func save(_ reminder: Reminder) throws -> Reminder.ID {
    guard isFullAccessAvailable() else {
      throw ReminderStoreError.accessDenied
    }
    let ekReminder: EKReminder
    do {
      ekReminder = try read(with: reminder.id)
    } catch {
      ekReminder = EKReminder(eventStore: eventStore)
    }
    ekReminder.update(using: reminder, in: eventStore)
    try eventStore.save(ekReminder, commit: true)
    return ekReminder.calendarItemIdentifier
  }

  func remove(with id: Reminder.ID) throws {
    guard isFullAccessAvailable() else {
      throw ReminderStoreError.accessDenied
    }
    let ekReminder = try read(with: id)
    try eventStore.remove(ekReminder, commit: true)
  }

  func refresh(with id: Reminder.ID) throws -> Bool {
    guard isFullAccessAvailable() else {
      throw ReminderStoreError.accessDenied
    }
    return try read(with: id).refresh()
  }

  private func read(with id: Reminder.ID) throws -> EKReminder {
    guard
      let ekReminder = eventStore.calendarItem(withIdentifier: id)
        as? EKReminder
    else {
      throw ReminderStoreError.failedReadingCalendar
    }
    return ekReminder
  }
}
