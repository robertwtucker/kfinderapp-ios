//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

enum Tab: Int, Identifiable, Hashable {
  case dashboard, foods, other
  
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
    case .other:
      EmptyView()
    }
  }
  
  static var validTabs: [Tab] {
    [.dashboard, .foods]
  }
  
  @ViewBuilder
  var label: some View {
    switch self {
    case .dashboard:
      Label("tab.dashboard", systemImage: iconName)
    case .foods:
      Label("tab.foods", systemImage: iconName)
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
    case .other:
      ""
    }
  }
}
