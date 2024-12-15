//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import DesignSystem
import SwiftUI

struct CallToActionButtonView: View {
  @Environment(\.colorScheme) private var colorScheme

  let label: LocalizedStringKey
  let icon: String?
  let action: () -> Void

  init(
    label: LocalizedStringKey, icon: String? = nil, action: @escaping () -> Void
  ) {
    self.label = label
    self.icon = icon
    self.action = action
  }

  var body: some View {
    Button {
      action()
    } label: {
      if let icon {
        Image(systemName: icon)
      }
      Text(label)
    }
    .asCallToActionButton(colorScheme: colorScheme)
  }
}

struct CallToActionRowView<Content: View>: View {
  @Environment(\.colorScheme) private var colorScheme

  let text: LocalizedStringKey
  @ViewBuilder let content: Content

  var body: some View {
    HStack {
      Text(text)
        .font(.callout)
      Spacer()
      content
    }
    .accentColor(Color.appForegroundInverted(for: colorScheme))
    .padding()
  }
}

struct CallToActionStackView<Content: View>: View {
  @Environment(\.colorScheme) private var colorScheme

  let text: LocalizedStringKey
  @ViewBuilder let content: Content

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(text)
        .font(.callout)
      content
    }
    .accentColor(Color.appForegroundInverted(for: colorScheme))
    .padding()
  }
}
