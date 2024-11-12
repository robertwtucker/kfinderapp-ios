//
//  File.swift
//  Services
//
//  Created by Robert Tucker on 11/6/24.
//

import EventKit
import Models

extension Reminder {
  public init(with ekReminder: EKReminder) throws {
    guard let dueDate = ekReminder.alarms?.first?.absoluteDate else {
      throw ReminderStoreError.reminderHasNoDueDate
    }
    self.init(
      id: ekReminder.calendarItemIdentifier, title: ekReminder.title,
      dueDate: dueDate, notes: ekReminder.notes,
      isComplete: ekReminder.isCompleted)
  }
}
