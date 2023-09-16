//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct AppTabView: View {
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    TabView(selection: $appState.currentTab) {
      DashboardView()
        .tabItem {
          Label("Dashboard", systemImage: "chart.bar")
        }.tag(AppTabs.dashboard)
      FoodsView()
        .tabItem {
          Label("Foods", systemImage: "takeoutbag.and.cup.and.straw")
        }.tag(AppTabs.foods)
      SettingsView()
        .tabItem {
          Label("Settings", systemImage: "gear")
        }.tag(AppTabs.settings)
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
    AppTabView().environmentObject(AppState())
  }
}
