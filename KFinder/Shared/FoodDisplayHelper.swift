//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Models

@Observable class FoodDisplayHelper {
  let food: FoodItem
  static let kNutrientNumberRegEx = /428|429|430/

  init(_ food: FoodItem) {
    self.food = food
  }

  public var category: String {
    return food.category?.capitalized ?? ""
  }
  
  public var extra: String {
    return food.extra?.capitalized ?? ""
  }
  
  public var citation: String {
    guard let publicationDate = food.publishedOn else {
      return "\(food.dataType)/\(food.id)"
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return "\(food.dataType)/\(food.id)/Pub:\(dateFormatter.string(from: publicationDate))"
  }
  
  public func vitaminKAsPercent(of target: Int) -> Double {
    if sumOfVitaminKValues > 0 {
      return sumOfVitaminKValues / Double(target)
    } else {
      return 0
    }
  }
  
  public var nutrientsWithVitaminK: [FoodNutrient] {
    guard let nutrients = food.nutrients else { return [] }
    do {
      return try nutrients.filter {
        try Self.kNutrientNumberRegEx.firstMatch(in: $0.number) != nil
      }
    } catch {
      return []
    }
  }
  
  public var nutrientsOtherThanVitaminK: [FoodNutrient] {
    guard let nutrients = food.nutrients else { return [] }
    do {
      return try nutrients.filter {
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
