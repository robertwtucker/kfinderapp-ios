//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct FoodNutrient: Codable {
  public let _id: Int
  public let nutrient: Nutrient
  public let amount: Double
  
  public enum CodingKeys: String, CodingKey {
    case _id = "id"
    case nutrient, amount
  }
}

extension FoodNutrient: Identifiable {
  public var id: Int { _id }
}

public struct Nutrient: Codable {
  public enum UnitName: String, Codable {
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
  }
  
  public let id: Int
  public let number: String
  public let name: String
  public let unitName: UnitName
}
