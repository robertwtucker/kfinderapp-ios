//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftData
import SwiftUI

struct ContentView: View {
  @State var reminderManager = ReminderManager.shared

  var body: some View {
    AppTabView()
      .environment(reminderManager)
      .modelContainer(for: [
        FoodItem.self
      ])
      .withErrorHandling()
      .task {
        await reminderManager.listenForReminderChanges()
      }
  }
}

#if DEBUG
  #Preview {
    ContentView()
      .environment(ReminderManager.shared)
      .modelContainer(previewContainer)
  }
#endif
