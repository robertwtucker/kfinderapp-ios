//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftData
import SwiftUI

@main
struct KFinderApp: App {
  var body: some Scene {
    @State var userPreferences = UserPreferences.shared
    @State var reminderManager = ReminderManager.shared

    WindowGroup {
      ContentView()
        .environment(userPreferences)
        .environment(reminderManager)
        .modelContainer(for: [
          FoodItem.self,
        ])
    }
  }
}
