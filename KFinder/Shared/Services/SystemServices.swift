//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct SystemServices: ViewModifier {
  
  @State private var appState = AppState()
  
  func body(content: Content) -> some View {
    content
//      .environment(appState)
  }
}
