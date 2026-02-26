//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import EventKit
import Models

extension Reminder {
  public init(with ekReminder: EKReminder) throws {
    guard let dueDate = ekReminder.alarms?.first?.absoluteDate else {
      throw ReminderStoreError.reminderHasNoDueDate
    }
    self.init(
      id: ekReminder.calendarItemExternalIdentifier, title: ekReminder.title,
      dueDate: dueDate, notes: ekReminder.notes,
      isCompleted: ekReminder.isCompleted)
  }
}
