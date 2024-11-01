//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct HomeStatusView: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var items: [String] = []  // (Notifications?)
//  @State var items = ["Alert1", "Alert2"]

  var body: some View {
    GeometryReader { geometry in
      VStack {
        HStack {
          Text("Next scheduled test...")
            .padding(.horizontal, 8)
            .foregroundStyle(colorScheme == .light ? .white : .black)
            .frame(maxWidth: .infinity, maxHeight: 200)
          Spacer()
        }.background(RoundedRectangle(cornerRadius: 16))
        ScrollView(Axis.Set.horizontal, showsIndicators: true) {
          HStack {
            ForEach(items, id: \.self) { item in
              Text(item)
                .padding(.horizontal, 8)
                .foregroundStyle(colorScheme == .light ? .white : .black)
                .frame(
                  width: items.count > 1
                  ? geometry.size.width - 24 : geometry.size.width - 8,
                  height: 150
                )
              Spacer()
            }.background(RoundedRectangle(cornerRadius: 16))
          }
        }
      }
    }
  }
}
