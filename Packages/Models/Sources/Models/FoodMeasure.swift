//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SwiftData

@Model public class FoodMeasure {
  public var id: Int
  public var text: String
  public var gramWeight: Double
  public var rank: Int
 
  public init(id: Int, text: String, gramWeight: Double, rank: Int) {
    self.id = id
    self.text = text
    self.gramWeight = gramWeight
    self.rank = rank
  }
  
  public init(from: SearchFoodMeasure) {
    self.id = from.id
    self.text = from.disseminationText
    self.gramWeight = from.gramWeight
    self.rank = from.rank
  }
  
  public var ounceWeight: Double {
    return gramWeight / 28.35
  }
}
