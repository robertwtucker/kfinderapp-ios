//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import SwiftData

@Model public class UserSettings {
  public var dailyKTarget: Double = 120
  public var setProTimeReminders: Bool = false
  public var defaultProTimeInterval: Int = 3
  public var defaultProTimeReminderTitle: String = "PT/INR Test"
  public var proTimeReminderId: String = ""
  public var recentFoodsLimit: Int = 5

  public init() {}
}
