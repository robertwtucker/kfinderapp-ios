//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

public extension Color {
  static let appIndigo = Color("indigo-500")
  static let appLightIndigo = Color("indigo-300")
  static let appLightGray = Color("neutral-200")
  static let appDarkGray = Color("neutral-800")
  
  static func appBaseBackground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .black : .appLightGray
  }
  
  static func appBackground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .appDarkGray : .white
  }
  
  static func appBackgroundInverted(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .white : .black
  }
  
  static func appForeground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .white : .black
  }
  
  static func appForegroundInverted(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .black : .white
  }
}


