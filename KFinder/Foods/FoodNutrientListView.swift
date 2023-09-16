//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodNutrientListView: View {
  let food: SearchFoodItem
  
  init(for food: SearchFoodItem) {
    self.food = food
  }
  
  var body: some View {
    List {
      Section("Vitamin K") {
        let kNutrients = food.nutrientsWithVitaminK()
        if kNutrients.isEmpty {
          Text("None reported")
        } else {
          ForEach(kNutrients) { kNutrient in
            FoodNutrientCellView(kNutrient)
          }
        }
      }
      Section("Other Nutrients") {
        let otherNutrients = food.nutrientsOtherThanVitaminK()
        if otherNutrients.isEmpty {
          Text("None reported")
        } else {
          ForEach(otherNutrients) { otherNutrient in
            FoodNutrientCellView(otherNutrient)
          }
        }
      }
    }
  }
}

