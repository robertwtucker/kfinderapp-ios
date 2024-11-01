//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Models
import SwiftData
import SwiftUI

struct ContentView: View {
  @State private var selectedTab: Tab = .home

  var body: some View {
    VStack {
      TabView(
        selection: .init(
          get: {
            selectedTab
          },
          set: { newTab in
            selectedTab = newTab
          })
      ) {
        ForEach(Tab.validTabs) { tab in
          tab.makeContentView()
            .tabItem {
              tab.label
            }
            .tag(tab)
        }
      }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(previewContainer)
}

@MainActor
let previewContainer: ModelContainer = {
  do {
    let container = try ModelContainer(
      for: FoodItem.self, configurations: .init(isStoredInMemoryOnly: true))
    for sample in FoodItem.samples {
      container.mainContext.insert(sample)
    }
    return container
  } catch {
    fatalError("Failed to create preview container")
  }
}()
