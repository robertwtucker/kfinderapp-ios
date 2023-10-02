//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct AppTabView: View {
  @Environment(AppState.self) private var appState
  
  var body: some View {
    @Bindable var state = appState
    
    TabView(selection: $state.currentTab) {
      DashboardView()
        .tabItem {
          Label("tab.dashboard", systemImage: "chart.bar")
        }
        .tag(AppTabs.dashboard)
      FoodsView()
        .tabItem {
          Label("tab.foods", systemImage: "takeoutbag.and.cup.and.straw")
        }
        .tag(AppTabs.foods)
      SettingsView()
        .tabItem {
          Label("tab.settings", systemImage: "gear")
        }
        .tag(AppTabs.settings)
    }
//    .onAppear {
//      if #available(iOS 15.0, *) {
//        let appearance = UITabBarAppearance()
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//      }
//    }
  }
}

struct AppTabView_Previews: PreviewProvider {
  static var previews: some View {
    AppTabView().environment(AppState())
  }
}
