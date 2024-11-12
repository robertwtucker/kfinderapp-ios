//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftData
import SwiftUI

struct ContentView: View {
  @State var userPreferences = UserPreferences.shared
  @State var reminderManager = ReminderManager.shared

  var body: some View {
    AppTabView()
      .environment(userPreferences)
      .environment(reminderManager)
      .modelContainer(for: [
        FoodItem.self
      ])
      .task {
        do {
          try await reminderManager.listenForReminderChanges()
        } catch {
          // display error
        }
      }
  }
}

#Preview {
  ContentView()
    .environment(UserPreferences.shared)
    .environment(ReminderManager.shared)
    .modelContainer(previewContainer)
}
