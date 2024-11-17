//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Services

enum TestingStatus {
  case disabled
  case enabled
  case scheduled
}

@MainActor
@Observable class TestingStatusHelper {
  private let userPreferences = UserPreferences.shared
  private let reminderManager = ReminderManager.shared
  var status: TestingStatus

  init() {
    if userPreferences.setProTimeReminders {
      if userPreferences.proTimeReminderId.isEmpty {
        status = .enabled
      } else {
        status = .scheduled
      }
    } else {
      status = .disabled
    }
  }

  var reminderDueDate: String {
    guard let reminder = reminderManager.reminder else {
      return "Unknown"
    }
    return Formatter.dueDateFormatter.string(from: reminder.dueDate)
  }
  
  func reminderIsComplete() -> Bool {
    guard let reminder = reminderManager.reminder else {
      return false
    }
    return reminder.isComplete
  }

  func reminderIsOverdue() -> Bool {
    guard let reminder = reminderManager.reminder else {
      return false
    }

    return reminder.dueDate.compare(Date.now) == .orderedAscending
  }
}
