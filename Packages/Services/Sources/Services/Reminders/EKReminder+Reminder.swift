//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import EventKit
import Foundation
import Models

extension EKReminder {
  func update(using reminder: Reminder, in store: EKEventStore) throws {
    title = reminder.title
    notes = reminder.notes
    isCompleted = reminder.isCompleted
    guard let defaultCalendar = store.defaultCalendarForNewReminders() else {
      throw ReminderStoreError.failedReadingCalendar
    }
    calendar = defaultCalendar
    alarms?.forEach { alarm in
      guard let absoluteDate = alarm.absoluteDate else { return }
      let comparison = Locale.current.calendar.compare(
        reminder.dueDate, to: absoluteDate, toGranularity: .minute)
      if comparison != .orderedSame {
        removeAlarm(alarm)
      }
    }
    if !hasAlarms {
      addAlarm(EKAlarm(absoluteDate: reminder.dueDate))
    }
  }
}
