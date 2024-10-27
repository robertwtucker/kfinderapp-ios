//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import Services

@main
struct KFinderApp: App {
  var body: some Scene {
    @State var userPreferences = UserPreferences.shared
    
    WindowGroup {
      ContentView()
        .environment(userPreferences)
    }
  }
}
