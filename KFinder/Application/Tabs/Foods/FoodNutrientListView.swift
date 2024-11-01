//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Models
import SwiftUI

struct FoodNutrientListView: View {
  let food: FoodItem

  var body: some View {
    let displayHelper = FoodDisplayHelper(food)

    List {
      Section("foods.nutrient.k") {
        let kNutrients = displayHelper.nutrientsWithVitaminK
        if kNutrients.isEmpty {
          Text("foods.nutrient.none")
        } else {
          ForEach(kNutrients) { kNutrient in
            foodNutrientRow(kNutrient)
          }
        }
      }
      Section("foods.nutrient.other") {
        let otherNutrients = displayHelper.nutrientsOtherThanVitaminK
        if otherNutrients.isEmpty {
          Text("foods.nutrient.none")
        } else {
          ForEach(otherNutrients) { otherNutrient in
            foodNutrientRow(otherNutrient)
          }
        }
      }
    }
  }

  private func foodNutrientRow(_ nutrient: FoodNutrient) -> some View {
    HStack {
      Text(nutrient.name)
      Spacer()
      Text(nutrient.unitValue)
    }
  }
}
