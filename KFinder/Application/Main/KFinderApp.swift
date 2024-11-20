//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI
import TelemetryDeck

@main
struct KFinderApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }

  init() {
    let config = TelemetryDeck.Config(appID: Secrets.TelemetryDeck.appId!)
    TelemetryDeck.initialize(config: config)
    TelemetryDeck.signal("app.launched")
  }
}
