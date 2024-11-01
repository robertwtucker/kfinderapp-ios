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
  @Query(RecentFoodsListView.fetchDescriptor) var foods: [FoodItem]

  static var fetchDescriptor: FetchDescriptor<FoodItem> {
    var descriptor = FetchDescriptor<FoodItem>(
      sortBy: [
        .init(\.updatedAt, order: .reverse)
      ]
    )
    // TODO: Make this configurable in Settings
    descriptor.fetchLimit = 5
    return descriptor
  }
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: RecentFoodsListView.self))

  @ViewBuilder
  var body: some View {

    VStack(alignment: .leading, spacing: 8) {
      Text("Recent Foods").font(.headline)
      ForEach(foods, id: \.self) { food in
        HStack {
          Text("\(food.name)")
            .frame(maxWidth: .infinity, maxHeight: 100)
            .foregroundStyle(colorScheme == .light ? .white : .black)
        }
        .background(RoundedRectangle(cornerRadius: 16))
      }
      Spacer()
    }
  }
}
