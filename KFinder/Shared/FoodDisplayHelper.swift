//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Models
import Services

@Observable class FoodDisplayHelper {

  let food: FoodItem
  static let kNutrientNumberRegEx = /428|429|430/

  init(_ food: FoodItem) {
    self.food = food
  }

  public var citation: String {
    if food.publicationDate == .distantPast {
      return "\(food.dataType)/\(food.id)"
    } else {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      return "\(food.dataType)/\(food.id)/pub:\(dateFormatter.string(from: food.publicationDate))"
    }
  }
  
  public func vitaminKAsPercent(of target: Int) -> Double {
    if sumOfVitaminKValues > 0 {
      return sumOfVitaminKValues / Double(target)
    } else {
      return 0
    }
  }
  
  public var nutrientsWithVitaminK: [FoodNutrient] {
    do {
      return try food.nutrients.filter {
        try Self.kNutrientNumberRegEx.firstMatch(in: $0.number) != nil
      }
    } catch {
      return []
    }
  }
  
  public var nutrientsOtherThanVitaminK: [FoodNutrient] {
    do {
      return try food.nutrients.filter {
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
