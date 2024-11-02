//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SwiftData

@Model public class UserSettings {
  var email: String = "user@kfinderapp.com"
  var firstName: String = "K"
  var lastName: String = "Finder"
  var dailyKTarget: Double = 120
  var setProTimeReminders: Bool = false
  var defaultProTimeInterval: Int = 3
  
  public init() { }
}
