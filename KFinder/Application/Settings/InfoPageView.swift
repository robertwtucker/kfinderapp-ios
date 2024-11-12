//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

struct InfoPageView: View {
  @Environment(\.dismiss) private var dismiss
  let info: LocalizedStringKey
  let footnote: LocalizedStringKey

  var body: some View {
    VStack(alignment: .leading, spacing: 32) {
      HStack {
        Spacer()
        Label("settings.about", systemImage: "info.circle.fill")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(.accentColor)
          .labelStyle(.iconOnly)
        Spacer()
      }
      Text(info)
        .multilineTextAlignment(.leading)
      Text(footnote).font(.footnote)
      Spacer()
      Button(
        action: {
          dismiss()
        },
        label: {
          HStack {
            Spacer()
            Text("button.dismiss")
            Spacer()
          }
        })
    }
    .padding()
  }
}

#Preview {
  InfoPageView(info: "settings.fdc.info", footnote: "settings.fdc.footnote")
}
