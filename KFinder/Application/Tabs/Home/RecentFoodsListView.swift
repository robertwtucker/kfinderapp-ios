//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Defaults
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
    descriptor.fetchLimit = Defaults[.recentFoodsLimit]
    return descriptor
  }

  var body: some View {
    if foods.count > 0 {
      ForEach(foods, id: \.self) { food in
        NavigationLink(destination: FoodDetailView(food: food)) {
          FoodsListCellView(food: food)
            .padding(.vertical)
        }
        .background(
          RoundedRectangle(cornerRadius: .cornerRadius)
            .fill(Color.appBackground(for: colorScheme))
            .withCardShadow()
        )
        .contextMenu {
          Button {
            modelContext.delete(food)
          } label: {
            Label("foods.recent.remove", systemImage: "trash")
          }
        }
      }
    } else {
      VStack(alignment: .leading) {
        HStack {
          HStack {
            Image(systemName: "carrot")
            Text("foods.recent.none")
          }
          .font(.headline)
          Spacer()
        }
        .padding(.vertical)
        Text("foods.recent.none.message")
          .font(.subheadline)
          .padding(.bottom)
      }
      .padding(.horizontal)
      .background(
        RoundedRectangle(cornerRadius: .cornerRadius)
          .fill(Color.appBackground(for: colorScheme))
          .withCardShadow()
      )
    }
  }
}

#if DEBUG
  #Preview {
    RecentFoodsListView()
      .modelContainer(previewContainer)
  }
#endif
