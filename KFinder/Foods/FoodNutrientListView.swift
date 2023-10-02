//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodNutrientListView: View {
  let food: SearchFoodItem
  
  var body: some View {
    List {
      Section("foods.nutrient.k") {
        let kNutrients = food.nutrientsWithVitaminK()
        if kNutrients.isEmpty {
          Text("foods.nutrient.none")
        } else {
          ForEach(kNutrients) { kNutrient in
            FoodNutrientCellView(nutrient: kNutrient)
          }
        }
      }
      Section("foods.nutrient.other") {
        let otherNutrients = food.nutrientsOtherThanVitaminK()
        if otherNutrients.isEmpty {
          Text("foods.nutrient.none")
        } else {
          ForEach(otherNutrients) { otherNutrient in
            FoodNutrientCellView(nutrient: otherNutrient)
          }
        }
      }
    }
  }
}

