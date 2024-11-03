//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

public extension Color {
  static let appIndigo = Color("indigo-500")
  static let appLightIndigo = Color("indigo-200")
  static let appLightGray = Color("neutral-200")
  static let appDarkGray = Color("neutral-800")
  
  static func appBaseBackground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .black : .appLightGray
  }
  
  static func appBackground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .appDarkGray : .white
  }
  
  static func appForeground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .white : .black
  }
}


