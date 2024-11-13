//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct AlignViewModifier: ViewModifier {
  let alignment: Alignment

  func body(content: Content) -> some View {
    content.frame(maxWidth: .infinity, alignment: alignment)
  }
}

struct AlignViewAndTextModifier: ViewModifier {
  let alignment: Alignment
  let textAlignment: TextAlignment

  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, alignment: alignment)
      .multilineTextAlignment(textAlignment)
  }
}

struct CardShadow: ViewModifier {
  func body(content: Content) -> some View {
    content
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
  }
}

struct FullWidthModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity)
  }
}

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
  public func alignView(_ alignment: Alignment) -> some View {
    self.modifier(AlignViewModifier(alignment: alignment))
  }

  public func alignViewAndText(
    _ alignment: Alignment,
    _ textAlignment: TextAlignment
  ) -> some View {
    self.modifier(
      AlignViewAndTextModifier(
        alignment: alignment,
        textAlignment: textAlignment
      )
    )
  }

  public func withCardShadow() -> some View {
    self.modifier(CardShadow())
  }

  public func fullWidth() -> some View {
    self.modifier(FullWidthModifier())
  }

  public func withGradient(startColor: Color, endColor: Color) -> some View {
    self.modifier(GradientModifier(startColor: startColor, endColor: endColor))
  }
}
