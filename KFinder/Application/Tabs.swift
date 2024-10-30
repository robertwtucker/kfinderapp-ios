//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

enum Tab: Int, Identifiable, Hashable {
  case home, foods, other
  
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
    case .other:
      EmptyView()
    }
  }
  
  static var validTabs: [Tab] {
    [.home, .foods]
  }
  
  @ViewBuilder
  var label: some View {
    switch self {
    case .home:
      Label("tab.home", systemImage: iconName)
    case .foods:
      Label("tab.foods", systemImage: iconName)
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
    case .other:
      ""
    }
  }
}
