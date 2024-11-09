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
        EmptyRecentFoodsView()
      }
    }
    .accentColor(Color.appForeground(for: colorScheme))
  }
}

struct EmptyRecentFoodsView: View {
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        HStack {
          Image(systemName: "carrot")
          Text("foods.recent.none")
        }
        Spacer()
      }
      .font(.headline)
      .padding()
      Text("foods.recent.none.message")
        .font(.subheadline)
        .padding(.horizontal)
      Spacer()
    }
    .padding(.bottom)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.appBackground(for: colorScheme))
        .shadow(radius: 1, x: 1, y: 1))
  }
}

#Preview {
  RecentFoodsListView()
    .environment(UserPreferences.shared)
    .modelContainer(previewContainer)
}
