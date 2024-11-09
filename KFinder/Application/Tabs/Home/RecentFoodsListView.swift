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
  @Environment(\.editMode) private var editMode
  @Environment(\.modelContext) private var modelContext
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

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
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
        .accentColor(Color.appForeground(for: colorScheme))
      }
      .onDelete { indexSet in
        for i in indexSet {
          let food = foods[i]
          modelContext.delete(food)
        }
      }
      Spacer()
    }
  }
}

#Preview {
  RecentFoodsListView()
    .environment(UserPreferences.shared)
    .modelContainer(previewContainer)
}
