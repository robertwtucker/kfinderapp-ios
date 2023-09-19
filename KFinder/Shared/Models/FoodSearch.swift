//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

@Observable class FoodSearch {
  enum DataSet: String, Codable {
    case branded = "Branded"
    case foundation = "Foundation"
    case survey = "Survey (FNDDS)"
    case legacy = "SR Legacy"
    case unspecified = ""
  }

  private let service = FoodDataCentralService()
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
