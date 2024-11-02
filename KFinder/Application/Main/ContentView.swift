//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Models
import Services
import SwiftData
import SwiftUI

struct ContentView: View {
  @State private var selectedTab: Tab = .home
  @State private var showSettings = false

  var body: some View {
    VStack {
      AppHeaderView(selectedTab: $selectedTab, showSettings: $showSettings)
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
    .sheet(isPresented: $showSettings) {
      SettingsView()
        .presentationDetents([.large])
    }
  }
}

struct AppHeaderView: View {
  @Binding var selectedTab: Tab
  @Binding var showSettings: Bool

  var body: some View {
    HStack {
      Text(selectedTab.header)
        .font(.largeTitle)
        .fontWeight(.bold)
      Spacer()
      ZStack {
        Button(action: {
          showSettings.toggle()
        }) {
          // TODO: Externalize/sync this color with theme definition
          Color(red: 180 / 255, green: 180 / 255, blue: 180 / 255)
            .frame(width: 50, height: 50)
            .clipShape(.circle)
        }
        Image(systemName: "gearshape")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.black)
      }
    }.padding(8)
  }
}

#Preview {
  ContentView()
    .environment(UserPreferences.shared)
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
