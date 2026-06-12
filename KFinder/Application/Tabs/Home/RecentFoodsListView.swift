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

  @Query(RecentFoodsListView.fetchDescriptor) private var foods: [RecentFood]

  static var fetchDescriptor: FetchDescriptor<RecentFood> {
    var descriptor = FetchDescriptor<RecentFood>(
      sortBy: [
        .init(\.viewedAt, order: .reverse)
      ]
    )
    descriptor.fetchLimit = UserPreferences.shared.recentFoodsLimit
    return descriptor
  }

  var body: some View {
    if foods.count > 0 {
      ForEach(foods, id: \.self) { food in
        // Tap-through to detail is restored by #96 (fetchFood by fdcId).
        RecentFoodCellView(food: food)
          .padding(.vertical)
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
    .environment(UserPreferences.shared)
    .modelContainer(previewContainer)
}
#endif
