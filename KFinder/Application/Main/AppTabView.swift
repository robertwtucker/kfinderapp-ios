//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import DesignSystem
import Services
import SwiftUI

struct AppTabView: View {
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
      .accentColor(Color.appDarkIndigo)
    }
    .sheet(isPresented: $showSettings) {
      SettingsView()
        .presentationDetents([.large])
    }
  }
}

struct AppHeaderView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Binding var selectedTab: Tab
  @Binding var showSettings: Bool

  var body: some View {
    HStack {
      Text(selectedTab.header)
        .font(.largeTitle).bold()
        .foregroundStyle(.black)
      Spacer()
      Button(action: {
        showSettings.toggle()
      }) {
        ZStack {
          Color.appLightIndigo
            .clipShape(.circle)
            .frame(width: 48, height: 48)
            .shadow(radius: 1)
          Image(systemName: "gearshape")
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundStyle(.black)
        }
        .accentColor(Color.appForeground(for: colorScheme))
      }
    }
  }
}

#Preview {
  AppTabView()
    .environment(UserPreferences.shared)
    .environment(ReminderManager.shared)
    .modelContainer(previewContainer)
}
