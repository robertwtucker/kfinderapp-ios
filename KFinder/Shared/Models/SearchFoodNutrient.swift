//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct SearchFoodNutrient: Codable {
  enum UnitName: String, Codable {
    case g = "G"
    case kJ = "KJ"
    case kcal = "KCAL"
    case mg = "MG"
    case ug = "UG"
  }
  
  let _id: Int
  let name: String
  let number: String
  let unitName: String
  let value: Double
  let indentLevel: Int
  
  enum CodingKeys: String, CodingKey {
    case _id = "nutrientId"
    case name = "nutrientName"
    case number = "nutrientNumber"
    case unitName, value, indentLevel
  }
  
  var unitOfMeasure: String {
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
  
  var unitValue: String {
    return "\(String(format: "%.f", value)) \(unitOfMeasure)"
  }
}

// MARK: - Identifiable
extension SearchFoodNutrient: Identifiable {
  public var id: Int { _id }
}

// MARK: - SearchFoodMeasure
struct SearchFoodMeasure: Codable {
  let disseminationText: String
  let gramWeight: Double
  let id: Int
  let rank: Int
  
  var ounceWeight: Double {
    return gramWeight / 28.35
  }
}
