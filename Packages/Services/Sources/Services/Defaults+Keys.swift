// SPDX-FileCopyrightText: (c) 2025 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Defaults
import Foundation

@MainActor
private let sharedDefaults = UserDefaults(
  suiteName: "group.dev.eclectic.kfinder.shared"
)!

@MainActor
public extension Defaults.Keys {
  static let lastUpdateCheck = Key<TimeInterval>(
    "lastUpdateCheck",
    default: 0,
    suite: sharedDefaults
  )
  static let dailyKTarget = Key<Double>(
    "dailyKTarget",
    default: 120,
    suite: sharedDefaults
  )
  static let setProTimeReminders = Key<Bool>(
    "setProTimeReminders",
    default: false,
    suite: sharedDefaults
  )
  static let defaultProTimeInterval = Key<Int>(
    "defaultProTimeInterval",
    default: 3,
    suite: sharedDefaults
  )
  static let defaultProTimeReminderTitle = Key<String>(
    "defaultProTimeReminderTitle",
    default: String(localized: "test.reminder.title"),
    suite: sharedDefaults
  )
  static let proTimeReminderId = Key<String>(
    "proTimeReminderId",
    default: "",
    suite: sharedDefaults
  )
  static let recentFoodsLimit = Key<Int>(
    "recentFoodsLimit",
    default: 5,
    suite: sharedDefaults
  )
}
