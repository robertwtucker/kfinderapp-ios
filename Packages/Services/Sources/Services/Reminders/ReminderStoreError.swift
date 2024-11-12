//
//  File.swift
//  Services
//
//  Created by Robert Tucker on 11/6/24.
//

import Foundation

public enum ReminderStoreError: LocalizedError {
  case accessDenied
  case accessRestricted
  case failedReadingCalendarItem
  case failedReadingReminders
  case failedToRemoveReminder
  case noDefaultReminderCalendar
  case reminderHasNoDueDate
  case unknown

  public var errorDescription: String? {
    switch self {
    case .accessDenied:
      return "KFinder doesn't have permission to reminders."
    case .accessRestricted:
      return "This device doesn't allow access to reminders."
    case .failedReadingCalendarItem:
      return "Failed to read the reminder's underlying calendar item."
    case .failedReadingReminders:
      return "Failed to read reminders."
    case .failedToRemoveReminder:
      return "Failed to remove reminder."
    case .noDefaultReminderCalendar:
      return "No default reminder calendar found."
    case .reminderHasNoDueDate:
      return "The reminder has no due date."
    case .unknown:
      return "An unknown error has occurred."
    }
  }
}
