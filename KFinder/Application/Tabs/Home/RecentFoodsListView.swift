//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import Services
import SwiftData
import SwiftUI

struct RecentFoodsListView: View {
  @Environment(\.colorScheme) private var colorScheme
  @Environment(\.modelContext) private var modelContext
  @Environment(\.defaultMinListRowHeight) var minRowHeight

  @Query(RecentFoodsListView.fetchDescriptor) private var foods: [FoodItem]

  static var fetchDescriptor: FetchDescriptor<FoodItem> {
    var descriptor = FetchDescriptor<FoodItem>(
      sortBy: [
        .init(\.updatedAt, order: .reverse)
      ]
    )
    descriptor.fetchLimit = UserPreferences.shared.recentFoodsLimit
    return descriptor
  }

  var body: some View {
    if foods.count > 0 {
      ForEach(foods, id: \.self) { food in
        NavigationLink(destination: FoodDetailView(food: food)) {
          FoodsListCellView(food: food)
            .padding(.vertical)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.appBackground(for: colorScheme))
                .shadow(radius: 1, x: 1, y: 1)
            )
        }
      }
    } else {
      VStack(alignment: .leading, spacing: 16) {
        HStack {
          HStack {
            Image(systemName: "carrot")
            Text("foods.recent.none")
          }
          .font(.headline)
          Spacer()
        }
        .padding(.horizontal)
        Text("foods.recent.none.message")
          .font(.subheadline)
          .padding(.horizontal)
      }
      .padding(.vertical)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(Color.appBackground(for: colorScheme))
      )
    }
  }
}

#Preview {
  RecentFoodsListView()
    .environment(UserPreferences.shared)
    .modelContainer(previewContainer)
}
