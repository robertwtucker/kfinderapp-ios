//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import CloudStorage
import Models
import SwiftUI

@MainActor
@Observable public class UserPreferences {

  @MainActor
  private class Storage: ObservableObject {
    @CloudStorage("dailyKTarget") var dailyKTarget: Double = 120
    @CloudStorage("setProTimeReminders") var setProTimeReminders: Bool = false
    @CloudStorage("defaultProTimeInterval") var defaultProTimeInterval: Int = 3
    @CloudStorage("proTimeReminderId") var proTimeReminderId: String = ""
    @CloudStorage("recentFoodsLimit") var recentFoodsLimit: Int = 5
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
