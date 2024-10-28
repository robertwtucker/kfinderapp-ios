//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SwiftData

@Model public class FoodNutrient {
  public var number: String = ""
  public var name: String = ""
  public var unitName: String = ""
  public var value: Double = 0
  // Optional FoodItem to auto-create inverse relationship
  public var food: FoodItem? = nil
  
  public init(number: String, name: String, unitName: String, value: Double, food: FoodItem? = nil) {
    self.number = number
    self.name = name
    self.unitName = unitName
    self.value = value
    self.food = food
  }
  
  public init(from: SearchFoodNutrient, food: FoodItem? = nil) {
    self.number = from.number
    self.name = from.name
    self.unitName = from.unitName
    self.value = from.value
    self.food = food
  }
  
  public var unitOfMeasure: String {
    switch unitName.lowercased() {
    case "kj":
      return "kJ"
    case "ug":
      return "µg"
    case "µg":
      return "µg"
    default:
      return unitName.lowercased()
    }
  }
  
  public var unitValue: String {
    return "\(String(format: "%.f", value)) \(unitOfMeasure)"
  }
}
