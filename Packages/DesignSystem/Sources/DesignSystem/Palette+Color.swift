//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

extension Color {
  public static let appIndigo = Color("indigo-500")
  public static let appLightIndigo = Color("indigo-300")
  public static let appDarkIndigo = Color("indigo-700")
  public static let appLightGray = Color("neutral-200")
  public static let appDarkGray = Color("neutral-800")

  public static func appBaseBackground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .black : .appLightGray
  }

  public static func appBackground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .appDarkGray : .white
  }

  public static func appBackgroundInverted(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .appLightGray : .appDarkGray
  }

  public static func appForeground(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .appLightGray : .black
  }

  public static func appForegroundInverted(for colorScheme: ColorScheme) -> Color {
    colorScheme == .dark ? .black : .white
  }
}
