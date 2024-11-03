//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import DesignSystem
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
            Color.appIndigo,
            Color.appLightGray,
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
      Button(action: {
        showSettings.toggle()
      }) {
        ZStack {
          Circle()
            .fill(Color.appLightIndigo)
            .frame(width: 48, height: 48)
            .shadow(radius: 1)
          Image(systemName: "gearshape")
            .resizable()
            .frame(width: 32, height: 32)
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
