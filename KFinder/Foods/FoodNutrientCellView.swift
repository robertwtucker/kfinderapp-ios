//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodNutrientCellView: View {
  let foodNutrient: SearchFoodNutrient
  
  init(_ foodNutrient: SearchFoodNutrient) {
    self.foodNutrient = foodNutrient
  }
  
  var body: some View {
    HStack {
      Text(foodNutrient.name)
      Spacer()
      Text(foodNutrient.unitValue)
    }
  }
}

