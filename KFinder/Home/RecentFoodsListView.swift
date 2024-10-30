//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Models
import OSLog
import SwiftData
import SwiftUI

struct RecentFoodsListView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Query(sort: \FoodItem.dateUpdated, order: .reverse)
  var foods: [FoodItem]

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: RecentFoodsListView.self))

  @ViewBuilder
  var body: some View {

    VStack(alignment: .leading, spacing: 8) {
      Text("Recent Foods")
      ForEach(foods, id: \.self) { food in
        HStack {
          Text("\(food.name)")
            .font(.headline)
            .frame(maxWidth: .infinity, maxHeight: 100)
            .foregroundStyle(colorScheme == .light ? .white : .black)
          //          Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 16))
      }
    }
  }
}

#Preview {
  RecentFoodsListView()
    .modelContainer(previewContainer)
}
