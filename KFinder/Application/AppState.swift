//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

enum AppTabs: Int {
  case dashboard
  case foods
  case settings
}

@Observable class AppState {
  var currentTab = AppTabs.foods
}
