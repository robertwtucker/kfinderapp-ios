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
          .fill(Color.appBackground(for: colorScheme))
          .shadow(radius: 1, x:1, y:1)
      )
      Spacer()
    }
  }
}

#Preview {
  HomeStatusView()
}
