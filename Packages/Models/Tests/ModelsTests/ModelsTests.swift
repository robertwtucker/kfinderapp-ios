//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Testing

@testable import Models

// MARK: - FoodNutrient Tests

@Suite("FoodNutrient")
struct FoodNutrientTests {

  @Suite("unitOfMeasure")
  struct UnitOfMeasure {
    @Test("normalizes KJ to kJ")
    func kilojoules() {
      let nutrient = FoodNutrient(
        number: "208", name: "Energy", unitName: "KJ", value: 100)
      #expect(nutrient.unitOfMeasure == "kJ")
    }

    @Test("normalizes kj to kJ (lowercase)")
    func kilojoulesLowercase() {
      let nutrient = FoodNutrient(
        number: "208", name: "Energy", unitName: "kj", value: 100)
      #expect(nutrient.unitOfMeasure == "kJ")
    }

    @Test("normalizes UG to µg")
    func microgramsFromUG() {
      let nutrient = FoodNutrient(
        number: "430", name: "Vitamin K", unitName: "UG", value: 10)
      #expect(nutrient.unitOfMeasure == "µg")
    }

    @Test("preserves µg as µg")
    func microgramsFromSymbol() {
      let nutrient = FoodNutrient(
        number: "430", name: "Vitamin K", unitName: "µg", value: 10)
      #expect(nutrient.unitOfMeasure == "µg")
    }

    @Test("lowercases other units")
    func otherUnitsLowercased() {
      let nutrient = FoodNutrient(
        number: "203", name: "Protein", unitName: "G", value: 25)
      #expect(nutrient.unitOfMeasure == "g")
    }

    @Test("lowercases KCAL")
    func kcalLowercased() {
      let nutrient = FoodNutrient(
        number: "208", name: "Energy", unitName: "KCAL", value: 200)
      #expect(nutrient.unitOfMeasure == "kcal")
    }

    @Test("lowercases MG")
    func milligramsLowercased() {
      let nutrient = FoodNutrient(
        number: "301", name: "Calcium", unitName: "MG", value: 100)
      #expect(nutrient.unitOfMeasure == "mg")
    }
  }

  @Suite("unitValue")
  struct UnitValue {
    @Test("formats integer value with unit")
    func integerValue() {
      let nutrient = FoodNutrient(
        number: "208", name: "Energy", unitName: "KCAL", value: 271)
      #expect(nutrient.unitValue == "271 kcal")
    }

    @Test("rounds fractional values")
    func roundedValue() {
      let nutrient = FoodNutrient(
        number: "317", name: "Selenium", unitName: "UG", value: 14.5)
      #expect(nutrient.unitValue == "14 µg")
    }

    @Test("formats zero value")
    func zeroValue() {
      let nutrient = FoodNutrient(
        number: "262", name: "Caffeine", unitName: "MG", value: 0.0)
      #expect(nutrient.unitValue == "0 mg")
    }
  }

  @Suite("init from SearchFoodNutrient")
  struct InitFromSearch {
    @Test("maps all fields correctly")
    func mapsFields() {
      let search = SearchFoodNutrient(
        _id: 1003, name: "Protein", number: "203",
        unitName: "G", value: 24.7, indentLevel: 1)
      let nutrient = FoodNutrient(from: search)
      #expect(nutrient.number == "203")
      #expect(nutrient.name == "Protein")
      #expect(nutrient.unitName == "G")
      #expect(nutrient.value == 24.7)
      #expect(nutrient.food == nil)
    }
  }
}

// MARK: - SearchFoodNutrient Tests

@Suite("SearchFoodNutrient")
struct SearchFoodNutrientTests {

  @Test("unitOfMeasure normalizes UG to µg")
  func micrograms() {
    let nutrient = SearchFoodNutrient(
      _id: 1185, name: "Vitamin K", number: "430",
      unitName: "UG", value: 1.5, indentLevel: 1)
    #expect(nutrient.unitOfMeasure == "µg")
  }

  @Test("unitOfMeasure normalizes KJ to kJ")
  func kilojoules() {
    let nutrient = SearchFoodNutrient(
      _id: 1008, name: "Energy", number: "208",
      unitName: "KJ", value: 100, indentLevel: 1)
    #expect(nutrient.unitOfMeasure == "kJ")
  }

  @Test("unitValue formats correctly")
  func unitValue() {
    let nutrient = SearchFoodNutrient(
      _id: 1003, name: "Protein", number: "203",
      unitName: "G", value: 24.7, indentLevel: 1)
    #expect(nutrient.unitValue == "25 g")
  }

  @Test("id returns nutrientId")
  func identifiable() {
    let nutrient = SearchFoodNutrient(
      _id: 1003, name: "Protein", number: "203",
      unitName: "G", value: 24.7, indentLevel: 1)
    #expect(nutrient.id == 1003)
  }
}

// MARK: - FoodMeasure Tests

@Suite("FoodMeasure")
struct FoodMeasureTests {

  @Test("ounceWeight converts grams to ounces")
  func gramToOunceConversion() {
    let measure = FoodMeasure(
      id: 1, text: "1 cup", gramWeight: 28.35, rank: 1)
    #expect(measure.ounceWeight == 1.0)
  }

  @Test("ounceWeight is zero for zero grams")
  func zeroGrams() {
    let measure = FoodMeasure(
      id: 1, text: "None", gramWeight: 0, rank: 1)
    #expect(measure.ounceWeight == 0.0)
  }

  @Test("ounceWeight handles typical gram weight")
  func typicalWeight() {
    let measure = FoodMeasure(
      id: 1, text: "1 slice", gramWeight: 21, rank: 1)
    let expected = 21.0 / 28.35
    #expect(abs(measure.ounceWeight - expected) < 0.0001)
  }

  @Test("init from SearchFoodMeasure maps fields")
  func initFromSearch() {
    let search = SearchFoodMeasure(
      disseminationText: "1 cup, shredded", gramWeight: 113,
      id: 269083, rank: 3)
    let measure = FoodMeasure(from: search)
    #expect(measure.id == 269083)
    #expect(measure.text == "1 cup, shredded")
    #expect(measure.gramWeight == 113)
    #expect(measure.rank == 3)
  }
}

// MARK: - SearchFoodMeasure Tests

@Suite("SearchFoodMeasure")
struct SearchFoodMeasureTests {

  @Test("ounceWeight converts grams to ounces")
  func gramToOunce() {
    let measure = SearchFoodMeasure(
      disseminationText: "1 oz", gramWeight: 28.35, id: 1, rank: 1)
    #expect(measure.ounceWeight == 1.0)
  }
}

// MARK: - FoodSearchCriteria Tests

@Suite("FoodSearchCriteria")
struct FoodSearchCriteriaTests {

  @Suite("DataSet raw values")
  struct DataSetRawValues {
    @Test("branded raw value")
    func branded() {
      #expect(FoodSearchCriteria.DataSet.branded.rawValue == "Branded")
    }

    @Test("foundation raw value")
    func foundation() {
      #expect(FoodSearchCriteria.DataSet.foundation.rawValue == "Foundation")
    }

    @Test("survey raw value")
    func survey() {
      #expect(
        FoodSearchCriteria.DataSet.survey.rawValue == "Survey (FNDDS)")
    }

    @Test("legacy raw value")
    func legacy() {
      #expect(FoodSearchCriteria.DataSet.legacy.rawValue == "SR Legacy")
    }

    @Test("unspecified raw value is empty")
    func unspecified() {
      #expect(FoodSearchCriteria.DataSet.unspecified.rawValue == "")
    }
  }

  @Suite("DataSet JSON round-trip")
  struct DataSetCodable {
    @Test(
      "encodes and decodes all cases",
      arguments: [
        FoodSearchCriteria.DataSet.branded,
        .foundation,
        .survey,
        .legacy,
        .unspecified
      ]
    )
    func roundTrip(dataSet: FoodSearchCriteria.DataSet) throws {
      let data = try JSONEncoder().encode(dataSet)
      let decoded = try JSONDecoder().decode(
        FoodSearchCriteria.DataSet.self, from: data)
      #expect(decoded == dataSet)
    }
  }

  @Suite("SortBy JSON round-trip")
  struct SortByCodable {
    @Test(
      "encodes and decodes all cases",
      arguments: [
        FoodSearchCriteria.SortBy.datatype,
        .description,
        .fdcid,
        .published
      ]
    )
    func roundTrip(sortBy: FoodSearchCriteria.SortBy) throws {
      let data = try JSONEncoder().encode(sortBy)
      let decoded = try JSONDecoder().decode(
        FoodSearchCriteria.SortBy.self, from: data)
      #expect(decoded == sortBy)
    }
  }

  @Suite("SortOrder JSON round-trip")
  struct SortOrderCodable {
    @Test(
      "encodes and decodes all cases",
      arguments: [
        FoodSearchCriteria.SortOrder.ascending,
        .descending
      ]
    )
    func roundTrip(sortOrder: FoodSearchCriteria.SortOrder) throws {
      let data = try JSONEncoder().encode(sortOrder)
      let decoded = try JSONDecoder().decode(
        FoodSearchCriteria.SortOrder.self, from: data)
      #expect(decoded == sortOrder)
    }
  }
}
