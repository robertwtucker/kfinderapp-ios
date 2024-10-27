//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct SearchFoodNutrient: Codable, Sendable {
  public enum UnitName: String, Codable {
    case g = "G"
    case kJ = "KJ"
    case kcal = "KCAL"
    case mg = "MG"
    case ug = "UG"
  }
  
  public let _id: Int
  public let name: String
  public let number: String
  public let unitName: String
  public let value: Double
  public let indentLevel: Int
  
  public enum CodingKeys: String, CodingKey {
    case _id = "nutrientId"
    case name = "nutrientName"
    case number = "nutrientNumber"
    case unitName, value, indentLevel
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

// MARK: - Identifiable
extension SearchFoodNutrient: Identifiable {
  public var id: Int { _id }
}
