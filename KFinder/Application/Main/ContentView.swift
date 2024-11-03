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
    VStack(spacing: 0) {
      ZStack {
        LinearGradient(
          gradient: Gradient(colors: [
            // TODO: Externalize/sync these colors with theme definition
            Color(red: 99 / 255, green: 102 / 255, blue: 241 / 255),  //indigo-500
            Color(red: 229 / 255, green: 229 / 255, blue: 229 / 255)  //neutral-200
          ]), startPoint: .top, endPoint: .bottom
        )
        .ignoresSafeArea()
        .frame(height: 72)
        AppHeaderView(selectedTab: $selectedTab, showSettings: $showSettings)
          .padding(.horizontal, 8)
      }
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
        .presentationDetents([.fraction(0.65), .fraction(0.95)])
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
      Button(action: {
        showSettings.toggle()
      }) {
        ZStack {
          // TODO: Externalize/sync this color with theme definition
          Color(red: 165 / 255, green: 180 / 255, blue: 252 / 255)  //indigo-300
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            .shadow(radius: 1)
          Image(systemName: "gearshape")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundStyle(.black)
        }
      }
    }
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
