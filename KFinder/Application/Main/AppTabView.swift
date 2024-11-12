//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import DesignSystem
import Services
import SwiftUI

struct AppTabView: View {
  @Environment(\.colorScheme) private var colorScheme
  @State private var selectedTab: Tab = .home
  @State private var showSettings = false

  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text(selectedTab.header)
          .style(.tabHeader)
        Spacer()
        Button(
          action: {
            showSettings.toggle()
          },
          label: {
            ZStack {
              Color.appLightIndigo
                .clipShape(.circle)
                .frame(width: 48, height: 48)
                .shadow(radius: 1)
              Image(systemName: "gearshape")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(Color.appForeground(for: colorScheme))
            }
          })
      }
      .padding(.horizontal, 8)
      .frame(height: 72)
      .withGradient(startColor: .appIndigo, endColor: .appLightGray)
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

#Preview {
  AppTabView()
    .environment(UserPreferences.shared)
    .environment(ReminderManager.shared)
    .modelContainer(previewContainer)
}
