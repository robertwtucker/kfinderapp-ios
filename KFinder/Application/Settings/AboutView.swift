//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct AboutView: View {
  var body: some View {
    VStack(spacing: 32) {
      Image(uiImage: UIImage(named: "about")!)
        .frame(width: 200, height: 200)
      VStack {
        Text("settings.about.kfinder")
          .font(.title)
        Text("v\(UIApplication.version)")
          .font(.subheadline)
          .padding(.top, -16)
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

    }
  }
}

#Preview {
  AboutView()
}
