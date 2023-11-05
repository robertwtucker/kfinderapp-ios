//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

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
