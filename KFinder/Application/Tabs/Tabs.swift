//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

enum Tab: Int, Identifiable, Hashable {
  case home, foods, settings, other
  
  var id: Int {
    rawValue
  }
  
  @ViewBuilder
  func makeContentView() -> some View {
    switch self {
    case .home:
      HomeTab()
    case .foods:
      FoodsTab()
    case .settings:
      SettingsTab()
    case .other:
      EmptyView()
    }
  }
  
  static var validTabs: [Tab] {
    [.home, .foods, .settings]
  }
  
  @ViewBuilder
  var label: some View {
    switch self {
    case .home:
      Label("tab.home", systemImage: iconName)
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
    case .home:
      "house"
    case .foods:
      "takeoutbag.and.cup.and.straw"
    case .settings:
      "person.crop.circle"
    case .other:
      ""
    }
  }
}
