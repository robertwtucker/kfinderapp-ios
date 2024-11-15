//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct InfoPageView: View {
  @Environment(\.colorScheme) private var colorScheme

  let info: LocalizedStringKey
  let footnote: LocalizedStringKey

  var body: some View {
    VStack(alignment: .leading, spacing: .aboutComponentSpacing) {
      HStack {
        Spacer()
        Label("settings.about", systemImage: "info.circle.fill")
          .labelStyle(.iconOnly)
          .font(.largeTitle).bold()
          .foregroundColor(.appIndigo)
        Spacer()
      }
      Text(info)
        .multilineTextAlignment(.leading)
      Text(footnote).font(.footnote)
    }
    .padding()
    .background(Color.appBaseBackground(for: colorScheme))
    .cornerRadius(.cornerRadius)
  }
}

#if DEBUG
#Preview {
  InfoPageView(info: "settings.fdc.info", footnote: "settings.fdc.footnote")
}
#endif
