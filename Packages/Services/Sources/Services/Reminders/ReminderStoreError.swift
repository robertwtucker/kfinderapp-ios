//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

public enum ReminderStoreError: LocalizedError {
  case accessDenied
  case accessRestricted
  case failedReadingCalendar
  case failedReadingReminder
  case failedRemovingReminder
  case reminderHasNoDueDate
  case unknown

  public var errorDescription: String? {
    switch self {
    case .accessDenied:
      return String(localized: "reminder.error.access.denied")
    case .accessRestricted:
      return String(localized: "reminder.error.access.restricted")
    case .failedReadingCalendar:
      return String(localized: "reminder.error.failed.ekevent")
    case .failedReadingReminder:
      return String(localized: "reminder.error.failed.reading")
    case .failedRemovingReminder:
      return String(localized: "reminder.error.failed.removing")
    case .reminderHasNoDueDate:
      return String(localized: "reminder.error.duedate")
    case .unknown:
      return String(localized: "reminder.error.unknown")
    }
  }
}
