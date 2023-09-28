//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodDetailView: View {
  let food: SearchFoodItem
  
  var body: some View {
    VStack {
      FoodHeaderView(food: food)
      FoodNutrientListView(food: food)
    }
  }
}

struct FoodDetailView_Previews: PreviewProvider {
  static var previews: some View {
    FoodDetailView(food: SearchFoodItem.samples[0])
  }
}
