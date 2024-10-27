//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Models
import Services

@Observable class FoodSearchHelper {

  private let service = FoodDataCentralService(apiKey: Secrets.FoodDataCentral.apiKey ?? "")
  
  var query = ""
  var foods: [SearchFoodItem] = []

  func search() async {
    guard let result = await service.searchFoods(for: query), let foods = result.foods else {
      self.foods = []
      return
    }
    self.foods = foods
    return
  }
}
