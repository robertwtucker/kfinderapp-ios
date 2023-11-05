//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct ContentView: View {
  @State private var selectedTab: Tab = .foods
  
  var body: some View {
    #if os(iOS)
    TabView(selection: .init(get: {
      selectedTab
    }, set: { newTab in
      selectedTab = newTab
    })) {
      ForEach(Tab.validTabs) { tab in
        tab.makeContentView()
          .tabItem {
            tab.label
          }
          .tag(tab)
      }
    }
    #endif
  }
}

#Preview {
  ContentView()
}
