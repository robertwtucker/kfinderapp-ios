//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct ContentView: View {
  @State private var appState = AppState()
  
  var body: some View {
    #if os(iOS)
//    AppTabView().modifier(SystemServices())
    AppTabView()
        .environment(appState)
    #endif
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
