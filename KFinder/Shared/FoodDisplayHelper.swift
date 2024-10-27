//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Models
import Services

@Observable class FoodDisplayHelper {

  let food: SearchFoodItem
  static let kNutrientNumberRegEx = /428|429|430/

  init(_ food: SearchFoodItem) {
    self.food = food
  }

  public func vitaminKAsPercent(of target: Int) -> Double {
    if sumOfVitaminKValues > 0 {
      return sumOfVitaminKValues / Double(target)
    } else {
      return 0
    }
  }
  
  public var nutrientsWithVitaminK: [SearchFoodNutrient] {
    guard let foodNutrients = food.foodNutrients else {
      return []
    }
    do {
      return try foodNutrients.filter {
        try Self.kNutrientNumberRegEx.firstMatch(in: $0.number) != nil
      }
    } catch {
      return []
    }
  }
  
  public var nutrientsOtherThanVitaminK: [SearchFoodNutrient] {
    guard let foodNutrients = food.foodNutrients else {
      return []
    }
    do {
      return try foodNutrients.filter {
        try Self.kNutrientNumberRegEx.firstMatch(in: $0.number) == nil
      }
    } catch {
      return []
    }
  }
  
  public var sumOfVitaminKValues: Double {
    nutrientsWithVitaminK.reduce(0) { $0 + $1.value }
  }
}
