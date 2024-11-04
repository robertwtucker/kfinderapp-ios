//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import SwiftData

@Model public class FoodMeasure {
  public var id: Int = 0
  public var text: String = ""
  public var gramWeight: Double = 0
  public var rank: Int = 0
  // Optional FoodItem to auto-create inverse relationship
  public var food: FoodItem? = nil

  public init(id: Int, text: String, gramWeight: Double, rank: Int, food: FoodItem? = nil) {
    self.id = id
    self.text = text
    self.gramWeight = gramWeight
    self.rank = rank
    self.food = food
  }
  
  public init(from: SearchFoodMeasure, food: FoodItem? = nil) {
    self.id = from.id
    self.text = from.disseminationText
    self.gramWeight = from.gramWeight
    self.rank = from.rank
    self.food = food
  }
  
  public var ounceWeight: Double {
    return gramWeight / 28.35
  }
}
