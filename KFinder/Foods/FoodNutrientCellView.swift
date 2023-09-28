//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodNutrientCellView: View {
  let nutrient: SearchFoodNutrient
  
  var body: some View {
    HStack {
      Text(nutrient.name)
      Spacer()
      Text(nutrient.unitValue)
    }
  }
}

