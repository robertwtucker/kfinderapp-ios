//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftData
import SwiftUI
import TelemetryDeck

@main
struct KFinderApp: App {
  let container: ModelContainer

  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(container)
    }
  }

  init() {
    let config = TelemetryDeck.Config(appID: Secrets.TelemetryDeck.appId!)
    TelemetryDeck.initialize(config: config)
    TelemetryDeck.signal("app.launched")

    do {
      container = try ModelContainer(
        for: FoodItem.self, RecentFood.self, UserSettings.self)
    } catch {
      fatalError("Failed to create ModelContainer: \(error)")
    }
    UserPreferences.shared.configure(with: container)
  }
}
