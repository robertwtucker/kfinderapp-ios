////
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import DesignSystem
import SwiftUI

struct AboutView: View {
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.dismiss) var dismiss

  var body: some View {
    VStack(spacing: .aboutComponentSpacing) {
      Image(uiImage: UIImage(named: "about")!)
        .frame(width: 200, height: 200)
      VStack {
        Text("settings.about.kfinder")
          .font(.title)
        Text("v\(UIApplication.version)")
          .font(.subheadline)
      }
      Text("settings.about.copyright")
        .font(.footnote)
      Text("settings.about.website")
      Text("settings.about.warranty")
        .multilineTextAlignment(.center)
        .padding(.horizontal)
      HStack {
        Text("settings.about.legal.privacy")
        Text(" – ")
        Text("settings.about.legal.terms")
        Text(" – ")
        Text("settings.about.legal.disclaimer")
      }
      Button {
        dismiss()
      } label: {
        Text("button.dismiss")
      }
      .padding(.bottom)
    }
    .background(Color.appBaseBackground(for: colorScheme))
    .cornerRadius(.cornerRadius)
  }
}

#if DEBUG
#Preview {
  AboutView()
}
#endif
