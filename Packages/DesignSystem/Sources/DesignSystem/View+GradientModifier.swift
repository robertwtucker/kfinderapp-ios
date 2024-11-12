//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct GradientModifier: ViewModifier {
  var startColor: Color
  var endColor: Color

  func body(content: Content) -> some View {
    content
      .background(
        LinearGradient(
          gradient: Gradient(colors: [startColor, endColor]), startPoint: .top,
          endPoint: .bottom)
      )
  }
}

extension View {
  public func withGradient(startColor: Color, endColor: Color) -> some View {
    self.modifier(GradientModifier(startColor: startColor, endColor: endColor))
  }
}
