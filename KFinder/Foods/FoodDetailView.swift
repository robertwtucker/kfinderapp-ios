//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import Models

struct FoodDetailView: View {
  let food: FoodItem
  
  var body: some View {
    let helper = FoodDisplayHelper(food)
    
    VStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(food.name)
          .font(.title)
        if let category = food.category {
          Text(category)
            .font(.headline)
        }
        if let extra = food.extraDesc {
          Text(extra.capitalized)
            .font(.callout)
        }
        HStack {
          Text(helper.citation).font(.footnote)
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
  FoodDetailView(food: FoodItem.samples[0])
}
