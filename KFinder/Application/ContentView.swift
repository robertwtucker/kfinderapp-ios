//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct ContentView: View {
  @State private var selectedTab: Tab = .foods
  @State private var showSettings = false
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button(action: {
          showSettings.toggle()
        }, label: {
          Label("settings.title", systemImage: "gear")
            .font(.title)
            .labelStyle(.iconOnly)
        })
      }
      .padding(.horizontal, 8)
      
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
    }
    .sheet(isPresented: $showSettings) {
      SettingsView(showSettings: $showSettings)
        .presentationDetents([.large])
    }
  }
}

#Preview {
  ContentView()
}
