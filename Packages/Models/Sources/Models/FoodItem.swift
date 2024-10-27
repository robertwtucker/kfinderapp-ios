//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SwiftData

@Model public class FoodItem: Equatable {
  public var id: Int
  public var name: String
  public var extraDesc: String?
  public var dataType: String
  public var category: String?
  public var publicationDate: Date
  public var nutrients: [FoodNutrient]
  public var measures: [FoodMeasure]

  public init(id: Int, name: String, extraDesc: String, dataType: String, category: String, publicationDate: Date, nutrients: [FoodNutrient], measures: [FoodMeasure]) {
    self.id = id
    self.name = name
    self.extraDesc = extraDesc
    self.dataType = dataType
    self.category = category
    self.publicationDate = publicationDate
    self.nutrients = nutrients
    self.measures = measures
  }

  public init(from: SearchFoodItem) {
    self.id = from.fdcId
    self.name = from.description
    self.extraDesc = from.additionalDescriptions
    self.dataType = from.foodDataType
    self.category = from.foodCategory

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    self.publicationDate = dateFormatter.date(from: from.publishedDate ?? "") ?? Date.distantPast

    self.nutrients = from.foodNutrients?.map { FoodNutrient(from: $0) } ?? []
    self.measures = from.foodMeasures?.map { FoodMeasure(from: $0) } ?? []
  }
}

// MARK: - Samples
extension FoodItem: @unchecked Sendable {
  public static let empty = FoodItem(
    id: 0,
    name: "",
    extraDesc: "",
    dataType: "",
    category: "",
    publicationDate: Date.distantPast,
    nutrients: [],
    measures: []
  )
  
  public static let samples = [
    FoodItem(
      id: 2341130,
      name: "Cheese, Muenster, reduced fat",
      extraDesc: "made with 2% milk;lowfat;part skim",
      dataType: FoodSearchCriteria.DataSet.survey.rawValue,
      category: "Cheese",
      publicationDate: Date.distantPast,
      nutrients: [
        FoodNutrient(number: "203", name: "Protein", unitName: "G", value: 24.7),
        FoodNutrient(number: "204", name: "Total lipid (fat)", unitName: "G", value: 17.6),
        FoodNutrient(number: "205", name: "Carbohydrate, by difference", unitName: "G", value: 3.5),
        FoodNutrient(number: "208", name: "Energy", unitName: "KCAL", value: 271),
        FoodNutrient(number: "221", name: "Alcohol, ethyl", unitName: "G", value: 0.0),
        FoodNutrient(number: "255", name: "Water", unitName: "G", value: 50.5),
        FoodNutrient(number: "262", name: "Caffeine", unitName: "MG", value: 0.0),
        FoodNutrient(number: "263", name: "Theobromine", unitName: "MG", value: 0.0),
        FoodNutrient(number: "269", name: "Sugars, total including NLEA", unitName: "G", value: 3.5),
        FoodNutrient(number: "291", name: "Fiber, total dietary", unitName: "G", value: 0.0),
        FoodNutrient(number: "301", name: "Calcium, Ca", unitName: "MG", value: 529),
        FoodNutrient(number: "303", name: "Iron, Fe", unitName: "MG", value: 0.41),
        FoodNutrient(number: "304", name: "Magnesium, Mg", unitName: "MG", value: 27.0),
        FoodNutrient(number: "305", name: "Phosphorus, P", unitName: "MG", value: 468),
        FoodNutrient(number: "306", name: "Potassium, K", unitName: "MG", value: 134),
        FoodNutrient(number: "307", name: "Sodium, Na", unitName: "MG", value: 600),
        FoodNutrient(number: "309", name: "Zinc, Zn", unitName: "MG", value: 2.81),
        FoodNutrient(number: "312", name: "Copper, Cu", unitName: "MG", value: 0.031),
        FoodNutrient(number: "317", name: "Selenium, Se", unitName: "UG", value: 14.5),
        FoodNutrient(number: "319", name: "Retinol", unitName: "UG", value: 174),
        FoodNutrient(number: "320", name: "Vitamin A, RAE", unitName: "UG", value: 175),
        FoodNutrient(number: "321", name: "Carotene, beta", unitName: "UG", value: 8.0),
        FoodNutrient(number: "322", name: "Carotene, alpha", unitName: "UG", value: 0.0),
        FoodNutrient(number: "323", name: "Vitamin E (alpha-tocopherol)", unitName: "MG", value: 0.15),
        FoodNutrient(number: "328", name: "Vitamin D (D2 + D3)", unitName: "UG", value: 0.3),
        FoodNutrient(number: "334", name: "Cryptoxanthin, beta", unitName: "UG", value: 0.0),
        FoodNutrient(number: "337", name: "Lycopene", unitName: "UG", value: 0.0),
        FoodNutrient(number: "338", name: "Lutein + zeaxanthin", unitName: "UG", value: 0.0),
        FoodNutrient(number: "401", name: "Vitamin C, total ascorbic acid", unitName: "MG", value: 0.0),
        FoodNutrient(number: "404", name: "Thiamin", unitName: "MG", value: 0.01),
        FoodNutrient(number: "405", name: "Riboflavin", unitName: "MG", value: 0.36),
        FoodNutrient(number: "406", name: "Niacin", unitName: "MG", value: 0.1),
        FoodNutrient(number: "415", name: "Vitamin B-6", unitName: "MG", value: 0.06),
        FoodNutrient(number: "417", name: "Folate, total", unitName: "UG", value: 12.0),
        FoodNutrient(number: "418", name: "Vitamin B-12", unitName: "UG", value: 1.47),
        FoodNutrient(number: "421", name: "Choline, total", unitName: "MG", value: 15.4),
        FoodNutrient(number: "430", name: "Vitamin K (phylloquinone)", unitName: "UG", value: 1.5),
        FoodNutrient(number: "431", name: "Folic acid", unitName: "UG", value: 0.0),
        FoodNutrient(number: "432", name: "Folate, food", unitName: "UG", value: 12.0),
        FoodNutrient(number: "435", name: "Folate, DFE", unitName: "UG", value: 12.0),
        FoodNutrient(number: "573", name: "Vitamin E, added", unitName: "MG", value: 0.0),
        FoodNutrient(number: "578", name: "Vitamin B-12, added", unitName: "UG", value: 0.0),
        FoodNutrient(number: "601", name: "Cholesterol", unitName: "MG", value: 63.0),
        FoodNutrient(number: "606", name: "Fatty acids, total saturated", unitName: "G", value: 11.0),
        FoodNutrient(number: "607", name: "SFA 4:0", unitName: "G", value: 0.571),
        FoodNutrient(number: "608", name: "SFA 6:0", unitName: "G", value: 0.337),
        FoodNutrient(number: "609", name: "SFA 8:0", unitName: "G", value: 0.197),
        FoodNutrient(number: "610", name: "SFA 10:0", unitName: "G", value: 0.442),
        FoodNutrient(number: "611", name: "SFA 12:0", unitName: "G", value: 0.494),
        FoodNutrient(number: "612", name: "SFA 14:0", unitName: "G", value: 1.77),
        FoodNutrient(number: "613", name: "SFA 16:0", unitName: "G", value: 4.62),
        FoodNutrient(number: "614", name: "SFA 18:0", unitName: "G", value: 2.14),
        FoodNutrient(number: "617", name: "MUFA 18:1", unitName: "G", value: 4.42),
        FoodNutrient(number: "618", name: "PUFA 18:2", unitName: "G", value: 0.397),
        FoodNutrient(number: "619", name: "PUFA 18:3", unitName: "G", value: 0.257),
        FoodNutrient(number: "620", name: "PUFA 20:4", unitName: "G", value: 0.0),
        FoodNutrient(number: "621", name: "PUFA 22:6 n-3 (DHA)", unitName: "G", value: 0.0),
        FoodNutrient(number: "626", name: "MUFA 16:1", unitName: "G", value: 0.394),
        FoodNutrient(number: "627", name: "PUFA 18:4", unitName: "G", value: 0.0),
        FoodNutrient(number: "628", name: "MUFA 20:1", unitName: "G", value: 0.265),
        FoodNutrient(number: "629", name: "PUFA 20:5 n-3 (EPA)", unitName: "G", value: 0.0),
        FoodNutrient(number: "630", name: "MUFA 22:1", unitName: "G", value: 0.0),
        FoodNutrient(number: "631", name: "PUFA 22:5 n-3 (DPA)", unitName: "G", value: 0.0),
        FoodNutrient(number: "645", name: "Fatty acids, total monounsaturated", unitName: "G", value: 5.09),
        FoodNutrient(number: "646", name: "Fatty acids, total polyunsaturated", unitName: "G", value: 0.65),
      ],
      measures: [
        FoodMeasure(id: 269085, text: "Quantity not specified", gramWeight: 21, rank: 5),
        FoodMeasure(id: 269081, text: "1 cracker-size slice", gramWeight: 9, rank: 1),
        FoodMeasure(id: 269083, text: "1 cup, shredded", gramWeight: 113, rank: 3),
        FoodMeasure(id: 269084, text: "1 cubic inch", gramWeight: 17.5, rank: 4),
        FoodMeasure(id: 269082, text: "1 slice", gramWeight: 21, rank: 2),
      ]
    )]
}
