//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct TestingStatusView: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("Next scheduled test...")
          .frame(maxWidth: .infinity)
          .foregroundStyle(colorScheme == .light ? .white : .black)
          .frame(maxWidth: .infinity, maxHeight: 150)
        Spacer()
      }
    }.background(RoundedRectangle(cornerRadius: 16))
  }
}

#Preview {
  TestingStatusView()
}
