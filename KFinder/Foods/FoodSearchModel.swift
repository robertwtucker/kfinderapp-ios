//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class FoodSearchModel: ObservableObject {
  private let service = FoodDataCentralService()
  static let kNutrientNumberRegEx = /428|429|430/
  
  @Published var searchText = ""
  @Published var searchFoods: [SearchFoodItem] = []

  @MainActor
  func search() async {
    guard let result = await service.searchFoods(for: searchText), let foods = result.foods else {
      searchFoods = []
      return
    }
    searchFoods = foods
    return
  }
}
