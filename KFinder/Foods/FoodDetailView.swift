//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodDetailView: View {
  let food: SearchFoodItem
  
  var body: some View {
    VStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(food.description)
          .font(.title)
        Text(food.foodCategory?.description ?? "")
          .font(.headline)
        if let extra = food.additionalDescriptions {
          Text(extra.capitalized)
            .font(.callout)
        }
        Text(food.citation)
          .font(.footnote)
          .padding(.top)
      }
      .padding(.horizontal, 8)
      FoodNutrientListView(food: food)
    }
  }
}

#Preview {
  FoodDetailView(food: SearchFoodItem.samples[0])
}
