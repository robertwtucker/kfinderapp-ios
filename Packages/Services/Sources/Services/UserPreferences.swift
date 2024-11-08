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
    @AppStorage("email", store: sharedDefaults) public var email: String = "user@kfinderapp.com"
    @AppStorage("firstName", store: sharedDefaults) public var firstName: String = "K"
    @AppStorage("lastName", store: sharedDefaults) public var lastName: String = "Finder"
    @AppStorage("dailyKTarget", store: sharedDefaults) public var dailyKTarget: Double = 120
    @AppStorage("setProTimeReminders", store: sharedDefaults) public var setProTimeReminders: Bool = false
    @AppStorage("defaultProTimeInterval", store: sharedDefaults) var defaultProTimeInterval: Int = 3
    @AppStorage("proTimeReminderId", store: sharedDefaults) var proTimeReminderId: String = ""
  }
  
  public static let sharedDefaults = UserDefaults(suiteName: "group.dev.eclectic.kfinder.shared")
  public static let shared = UserPreferences()
  private let storage = Storage()
  
  public var email: String {
    didSet {
      storage.email = email
    }
  }
  
  public var firstName: String {
    didSet {
      storage.firstName = firstName
    }
  }
  
  public var lastName: String {
    didSet {
      storage.lastName = lastName
    }
  }
  
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
  
  private init() {
    email = storage.email
    firstName = storage.firstName
    lastName = storage.lastName
    dailyKTarget = storage.dailyKTarget
    setProTimeReminders = storage.setProTimeReminders
    defaultProTimeInterval = storage.defaultProTimeInterval
    proTimeReminderId = storage.proTimeReminderId
  }
}
