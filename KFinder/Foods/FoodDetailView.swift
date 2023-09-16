//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodDetailView: View {
  let food: SearchFoodItem
  
  init(_ food: SearchFoodItem) {
    self.food = food
  }
  
  var body: some View {
    VStack {
      FoodHeaderView(for: food)
      FoodNutrientListView(for: food)
    }
  }
}

struct FoodDetailView_Previews: PreviewProvider {
  static var previews: some View {
    FoodDetailView(SearchFoodItem.samples[0])
  }
}
