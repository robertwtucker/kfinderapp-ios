//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Defaults
import Foundation
import Models
import Services

enum TestReminderStatus {
  case disabled
  case enabled
  case scheduled
}

@MainActor
@Observable class TestReminderModel {
  var reminder: Reminder?

  init(_ reminder: Reminder? = nil) {
    self.reminder = reminder
  }

  var status: TestReminderStatus {
    if Defaults[.setProTimeReminders] {
      if Defaults[.proTimeReminderId].isEmpty || reminder == nil {
        return .enabled
      } else {
        return .scheduled
      }
    } else {
      return .disabled
    }
  }

  var isDueOn: String {
    guard let reminder = reminder else {
      return "_unset_"
    }
    return Formatter.dueDateFormatter.string(from: reminder.dueDate)
  }

  func isCompleted() -> Bool {
    guard let reminder = reminder else {
      return false
    }
    return reminder.isCompleted
  }

  func isOverDue() -> Bool {
    guard let reminder = reminder else {
      return false
    }
    return reminder.dueDate.compare(Date.now) == .orderedAscending
  }
}
