//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import SwiftUI

@MainActor
@Observable public class UserPreferences {

  @MainActor
  private class Storage {
    @AppStorage("dailyKTarget", store: sharedDefaults)
    public var dailyKTarget: Double = 120
    @AppStorage("setProTimeReminders", store: sharedDefaults)
    public var setProTimeReminders: Bool = false
    @AppStorage("defaultProTimeInterval", store: sharedDefaults)
    var defaultProTimeInterval: Int = 3
    @AppStorage("proTimeReminderId", store: sharedDefaults)
    var proTimeReminderId: String = ""
    @AppStorage("recentFoodsLimit", store: sharedDefaults)
    var recentFoodsLimit: Int = 5
  }

  public static let sharedDefaults = UserDefaults(
    suiteName: "group.dev.eclectic.kfinder.shared")
  public static let shared = UserPreferences()
  private let storage = Storage()

  public var dailyKTarget: Double {
    didSet {
      storage.dailyKTarget = dailyKTarget
    }
  }

  public var setProTimeReminders: Bool {
    didSet {
      storage.setProTimeReminders = setProTimeReminders
    }
  }

  public var defaultProTimeInterval: Int {
    didSet {
      storage.defaultProTimeInterval = defaultProTimeInterval
    }
  }

  public var proTimeReminderId: String {
    didSet {
      storage.proTimeReminderId = proTimeReminderId
    }
  }

  public var recentFoodsLimit: Int {
    didSet {
      storage.recentFoodsLimit = recentFoodsLimit
    }
  }

  private init() {
    dailyKTarget = storage.dailyKTarget
    setProTimeReminders = storage.setProTimeReminders
    defaultProTimeInterval = storage.defaultProTimeInterval
    proTimeReminderId = storage.proTimeReminderId
    recentFoodsLimit = storage.recentFoodsLimit
  }
}
