//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodHeaderView: View {
  let food: SearchFoodItem
  
  var body: some View {
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
    .padding(.horizontal)
  }
}
