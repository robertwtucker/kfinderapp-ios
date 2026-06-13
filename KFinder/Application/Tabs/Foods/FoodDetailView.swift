//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import OSLog
import Services
import SwiftData
import SwiftUI

struct FoodDetailView: View {
  @Environment(\.modelContext) private var context
  @Query private var recents: [RecentFood]
  @State var food: FoodItem

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodDetailView.self))

  init(food: FoodItem) {
    self.food = food
    let fdcId = food.id
    _recents = Query(filter: #Predicate<RecentFood> { $0.fdcId == fdcId })
  }

  var body: some View {
    let helper = FoodDisplayHelper(food)

    VStack {
      VStack(alignment: .leading, spacing: .foodComponentPadding) {
        Text(food.name)
          .font(.title)
        Text(helper.category)
          .font(.headline)
        Text(helper.extra)
          .font(.callout)
        HStack {
          Text(helper.citation).font(.footnote)
          Spacer()
          Text("foods.portion.default").font(.headline)
        }.padding(.top, 4)
      }
      .padding(.horizontal, 24)
      FoodNutrientListView(food: food)
    }
    .onAppear {
      let vitaminKPer100g = helper.sumOfVitaminKValues
      if let stored = recents.first {
        logger.debug("Updating recent food: '[\(food.id)]  \(food.name)'")
        stored.viewedAt = .now
        stored.vitaminKPer100g = vitaminKPer100g
      } else {
        logger.debug("Storing new recent food: '[\(food.id)]  \(food.name)'")
        context.insert(
          RecentFood(from: food, vitaminKPer100g: vitaminKPer100g))
      }
      try? context.save()
      // Write-time prune — bounds the store, not the fetch (#95).
      UserPreferences.shared.enforceRecentFoodsLimit()
    }
  }
}

#if DEBUG
#Preview {
  FoodDetailView(food: FoodItem.samples[1])
}
#endif
