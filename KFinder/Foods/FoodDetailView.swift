//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import Models

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
        HStack {
          Text(food.citation).font(.footnote)
          Spacer()
          Text("foods.portion.default").font(.headline)
        }.padding(.top, 4)
      }
      .padding(.horizontal, 24)
      FoodNutrientListView(food: food)
    }
  }
}

#Preview {
  FoodDetailView(food: SearchFoodItem.samples[0])
}
