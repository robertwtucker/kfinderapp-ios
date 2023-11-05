//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

enum Tab: Int, Identifiable, Hashable {
  case dashboard, foods, settings, other
  
  var id: Int {
    rawValue
  }
  
  @ViewBuilder
  func makeContentView() -> some View {
    switch self {
    case .dashboard:
      DashboardTab()
    case .foods:
      FoodsTab()
    case .settings:
      SettingsTab()
    case .other:
      EmptyView()
    }
  }
  
  static var validTabs: [Tab] {
    [.dashboard, .foods, .settings]
  }
  
  @ViewBuilder
  var label: some View {
    switch self {
    case .dashboard:
      Label("tab.dashboard", systemImage: iconName)
    case .foods:
      Label("tab.foods", systemImage: iconName)
    case .settings:
      Label("tab.settings", systemImage: iconName)
    case .other:
      EmptyView()
    }
  }
  
  var iconName: String {
    switch self {
    case .dashboard:
      "chart.bar"
    case .foods:
      "takeoutbag.and.cup.and.straw"
    case .settings:
      "gear"
    case .other:
      ""
    }
  }
}
