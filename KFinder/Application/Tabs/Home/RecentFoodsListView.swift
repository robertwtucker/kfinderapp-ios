//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
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
    VStack(alignment: .leading, spacing: 16) {
      ForEach(foods, id: \.self) { food in
        VStack {
          Group {
            HStack {
              Text("\(food.name)")
                .font(.headline)
                .foregroundStyle(Color.appForeground(for: colorScheme))
                .padding(.vertical, 24)
                .padding(.horizontal)
              Spacer()
            }
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.appBackground(for: colorScheme))
                .shadow(radius: 1, x: 1, y: 1)
            )
          }
        }
      }
      Spacer()
    }
  }
}

#Preview {
  RecentFoodsListView()
    .modelContainer(previewContainer)
}
