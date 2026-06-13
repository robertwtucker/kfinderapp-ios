//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation

// Shape returned by GET /fdc/v1/food/{fdcId}?format=full.
// This is a different shape than `SearchFoodItem` (which models the search-hit
// projection) — `nutrient` is nested, `amount` replaces `value`, dates use
// "M/d/yyyy" instead of "yyyy-MM-dd", and portions live under `foodPortions`
// rather than `foodMeasures`. Kept as a distinct Codable so the two API
// surfaces can evolve independently. See issue #96.
public struct FoodDetailResponse: Codable, Sendable {
  public let fdcId: Int
  public let description: String
  // FNDDS may report this as "Survey (FNDDS)" or as a `foodClass` value.
  public let dataType: String?
  public let foodClass: String?
  // FDC publishes detail dates as "M/d/yyyy" — distinct from search's
  // "yyyy-MM-dd" formatting.
  public let publicationDate: String?
  public let wweiaFoodCategory: WWEIAFoodCategory?
  public let foodAttributes: [DetailFoodAttribute]?
  public let foodNutrients: [DetailFoodNutrient]
  public let foodPortions: [DetailFoodPortion]?

  public init(
    fdcId: Int, description: String,
    dataType: String? = nil, foodClass: String? = nil,
    publicationDate: String? = nil,
    wweiaFoodCategory: WWEIAFoodCategory? = nil,
    foodAttributes: [DetailFoodAttribute]? = nil,
    foodNutrients: [DetailFoodNutrient] = [],
    foodPortions: [DetailFoodPortion]? = nil
  ) {
    self.fdcId = fdcId
    self.description = description
    self.dataType = dataType
    self.foodClass = foodClass
    self.publicationDate = publicationDate
    self.wweiaFoodCategory = wweiaFoodCategory
    self.foodAttributes = foodAttributes
    self.foodNutrients = foodNutrients
    self.foodPortions = foodPortions
  }
}

public struct WWEIAFoodCategory: Codable, Sendable {
  public let wweiaFoodCategoryCode: Int?
  public let wweiaFoodCategoryDescription: String?

  public init(
    wweiaFoodCategoryCode: Int? = nil,
    wweiaFoodCategoryDescription: String? = nil
  ) {
    self.wweiaFoodCategoryCode = wweiaFoodCategoryCode
    self.wweiaFoodCategoryDescription = wweiaFoodCategoryDescription
  }
}

public struct DetailFoodAttribute: Codable, Sendable {
  public let id: Int?
  // FDC encodes `value` heterogeneously across attribute types (String for
  // descriptions, Int for category codes). We only care about the String
  // case; everything else decodes to nil and the consumer skips it.
  public let value: String?
  public let sequenceNumber: Int?
  public let name: String?
  public let foodAttributeType: DetailFoodAttributeType?

  enum CodingKeys: String, CodingKey {
    case id, value, sequenceNumber, name, foodAttributeType
  }

  public init(
    id: Int? = nil, value: String? = nil,
    sequenceNumber: Int? = nil, name: String? = nil,
    foodAttributeType: DetailFoodAttributeType? = nil
  ) {
    self.id = id
    self.value = value
    self.sequenceNumber = sequenceNumber
    self.name = name
    self.foodAttributeType = foodAttributeType
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    self.sequenceNumber = try container.decodeIfPresent(
      Int.self, forKey: .sequenceNumber)
    self.name = try container.decodeIfPresent(String.self, forKey: .name)
    self.foodAttributeType = try container.decodeIfPresent(
      DetailFoodAttributeType.self, forKey: .foodAttributeType)
    self.value = try? container.decodeIfPresent(String.self, forKey: .value)
  }
}

public struct DetailFoodAttributeType: Codable, Sendable {
  public let id: Int?
  public let name: String?
  public let description: String?

  public init(id: Int? = nil, name: String? = nil, description: String? = nil) {
    self.id = id
    self.name = name
    self.description = description
  }
}

public struct DetailFoodNutrient: Codable, Sendable {
  public let id: Int?
  public let amount: Double?
  public let nutrient: DetailNutrient?
  public let type: String?

  public init(
    id: Int? = nil, amount: Double? = nil,
    nutrient: DetailNutrient? = nil, type: String? = nil
  ) {
    self.id = id
    self.amount = amount
    self.nutrient = nutrient
    self.type = type
  }
}

public struct DetailNutrient: Codable, Sendable {
  public let id: Int?
  public let number: String?
  public let name: String?
  public let unitName: String?
  public let rank: Int?

  public init(
    id: Int? = nil, number: String? = nil, name: String? = nil,
    unitName: String? = nil, rank: Int? = nil
  ) {
    self.id = id
    self.number = number
    self.name = name
    self.unitName = unitName
    self.rank = rank
  }
}

public struct DetailFoodPortion: Codable, Sendable {
  public let id: Int
  public let gramWeight: Double
  public let measureUnit: DetailMeasureUnit?
  public let modifier: String?
  public let portionDescription: String?
  public let sequenceNumber: Int?

  public init(
    id: Int, gramWeight: Double,
    measureUnit: DetailMeasureUnit? = nil,
    modifier: String? = nil, portionDescription: String? = nil,
    sequenceNumber: Int? = nil
  ) {
    self.id = id
    self.gramWeight = gramWeight
    self.measureUnit = measureUnit
    self.modifier = modifier
    self.portionDescription = portionDescription
    self.sequenceNumber = sequenceNumber
  }
}

public struct DetailMeasureUnit: Codable, Sendable {
  public let id: Int?
  public let name: String?
  public let abbreviation: String?

  public init(
    id: Int? = nil, name: String? = nil, abbreviation: String? = nil
  ) {
    self.id = id
    self.name = name
    self.abbreviation = abbreviation
  }
}
