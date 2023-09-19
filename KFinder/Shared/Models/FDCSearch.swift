//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

@Observable class FDCSearch {
  private let service = FoodDataCentralService()
  static let kNutrientNumberRegEx = /428|429|430/
  
  var query = ""
  var foods: [SearchFoodItem] = []

  @MainActor
  func loadAsync() async {
    guard let result = await service.searchFoods(for: query), let foods = result.foods else {
      self.foods = []
      return
    }
    self.foods = foods
    return
  }
}
