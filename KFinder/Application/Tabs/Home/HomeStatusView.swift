//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct HomeStatusView: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Next scheduled test...")
          .font(.headline)
          .foregroundStyle(colorScheme == .light ? .black : .white)
          .padding(.horizontal)
          .padding(.vertical, 24)
        Spacer()
      }
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(
            colorScheme == .light
              ? Color.white
            // TODO: Externalize/sync this color with theme definition
              : Color(red: 40 / 255, green: 40 / 255, blue: 40 / 255) //neutral-750
          )
          .shadow(radius: 1, x:1, y:1)
      )
      Spacer()
    }
  }
}

#Preview {
  HomeStatusView()
}
