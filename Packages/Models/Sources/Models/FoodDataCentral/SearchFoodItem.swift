//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation

public struct SearchFoodItem: Codable, Sendable {
  // Unique ID of the food.
  public let fdcId: Int
  // The type of the food data.
  public let dataType: FoodSearchCriteria.DataSet
  // The description of the food.
  public let description: String
  // Additional information describing the food.
  public let additionalDescriptions: String?
  // A unique ID identifying the food within FNDDS -- only applies to Survey Foods
  public let foodCode: Int?
  // Date the item was published to FDC.
  public let publishedDate: String?
  // A grouping of foods within FNDDS -- only applies to Survey Foods
  public let foodCategory: String?
  // Nutrients in the food.
  public let foodNutrients: [SearchFoodNutrient]?
  // Standardized portion measures -- only applies to Survey Foods
  public let foodMeasures: [SearchFoodMeasure]?
  // Brand owner for the food -- only applies to Branded Foods
  public let brandOwner: String?
  // GTIN or UPC code identifying the food -- only applies to Branded Foods
  public let gtinUpc: String?
  // Unique number assigned for foundation foods -- only applies to Foundation and SRLegacy Foods
  public let ndbNumber: Int?

  public init(
    fdcId: Int, dataType: FoodSearchCriteria.DataSet, description: String,
    additionalDescriptions: String? = nil,
    foodCode: Int? = nil, publishedDate: String? = nil,
    foodCategory: String? = nil,
    foodNutrients: [SearchFoodNutrient]? = nil,
    foodMeasures: [SearchFoodMeasure]? = nil,
    brandOwner: String? = nil, gtinUpc: String? = nil, ndbNumber: Int? = nil
  ) {
    self.fdcId = fdcId
    self.dataType = dataType
    self.description = description
    self.additionalDescriptions = additionalDescriptions
    self.foodCode = foodCode
    self.publishedDate = publishedDate
    self.foodCategory = foodCategory
    self.foodNutrients = foodNutrients
    self.foodMeasures = foodMeasures
    self.brandOwner = brandOwner
    self.gtinUpc = gtinUpc
    self.ndbNumber = ndbNumber
  }

  public var foodDataType: String {
    switch dataType {
    case .branded:
      return "Branded"
    case .foundation:
      return "Foundation"
    case .legacy:
      return "SR Legacy"
    case .survey:
      return "Survey"
    default:
      return "Unspecified"
    }
  }
}

// MARK: - Identifiable
extension SearchFoodItem: Identifiable {
  public var id: Int { fdcId }
}

// MARK: - Hashable
extension SearchFoodItem: Hashable {
  public static func == (lhs: SearchFoodItem, rhs: SearchFoodItem) -> Bool {
    return lhs.fdcId == rhs.fdcId
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(fdcId)
  }
}

// MARK: - Samples
extension SearchFoodItem {
  public static let empty = SearchFoodItem(
    fdcId: 0, dataType: .unspecified, description: "")
  public static let samples = [
    SearchFoodItem(
      fdcId: 2_341_130,
      dataType: .survey,
      description: "Cheese, Muenster, reduced fat",
      additionalDescriptions: "made with 2% milk;lowfat;part skim",
      foodCode: 14_107_250,
      publishedDate: "2022-10-28",
      foodCategory: "Cheese",
      foodNutrients: [
        SearchFoodNutrient(
          _id: 1003, name: "Protein", number: "203", unitName: "G", value: 24.7,
          indentLevel: 1),
        SearchFoodNutrient(
          _id: 1004, name: "Total lipid (fat)", number: "204", unitName: "G",
          value: 17.6, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1005, name: "Carbohydrate, by difference", number: "205",
          unitName: "G", value: 3.5, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1008, name: "Energy", number: "208", unitName: "KCAL",
          value: 271, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1018, name: "Alcohol, ethyl", number: "221", unitName: "G",
          value: 0.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1051, name: "Water", number: "255", unitName: "G", value: 50.5,
          indentLevel: 1),
        SearchFoodNutrient(
          _id: 1057, name: "Caffeine", number: "262", unitName: "MG",
          value: 0.0, indentLevel: 0),
        SearchFoodNutrient(
          _id: 1058, name: "Theobromine", number: "263", unitName: "MG",
          value: 0.0, indentLevel: 0),
        SearchFoodNutrient(
          _id: 2000, name: "Sugars, total including NLEA", number: "269",
          unitName: "G", value: 3.5, indentLevel: 3),
        SearchFoodNutrient(
          _id: 1079, name: "Fiber, total dietary", number: "291", unitName: "G",
          value: 0.0, indentLevel: 3),
        SearchFoodNutrient(
          _id: 1087, name: "Calcium, Ca", number: "301", unitName: "MG",
          value: 529, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1089, name: "Iron, Fe", number: "303", unitName: "MG",
          value: 0.41, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1090, name: "Magnesium, Mg", number: "304", unitName: "MG",
          value: 27.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1091, name: "Phosphorus, P", number: "305", unitName: "MG",
          value: 468, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1092, name: "Potassium, K", number: "306", unitName: "MG",
          value: 134, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1093, name: "Sodium, Na", number: "307", unitName: "MG",
          value: 600, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1095, name: "Zinc, Zn", number: "309", unitName: "MG",
          value: 2.81, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1098, name: "Copper, Cu", number: "312", unitName: "MG",
          value: 0.031, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1103, name: "Selenium, Se", number: "317", unitName: "UG",
          value: 14.5, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1105, name: "Retinol", number: "319", unitName: "UG", value: 174,
          indentLevel: 2),
        SearchFoodNutrient(
          _id: 1106, name: "Vitamin A, RAE", number: "320", unitName: "UG",
          value: 175, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1107, name: "Carotene, beta", number: "321", unitName: "UG",
          value: 8.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1108, name: "Carotene, alpha", number: "322", unitName: "UG",
          value: 0.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1109, name: "Vitamin E (alpha-tocopherol)", number: "323",
          unitName: "MG", value: 0.15, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1114, name: "Vitamin D (D2 + D3)", number: "328", unitName: "UG",
          value: 0.3, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1120, name: "Cryptoxanthin, beta", number: "334", unitName: "UG",
          value: 0.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1122, name: "Lycopene", number: "337", unitName: "UG",
          value: 0.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1123, name: "Lutein + zeaxanthin", number: "338", unitName: "UG",
          value: 0.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1162, name: "Vitamin C, total ascorbic acid", number: "401",
          unitName: "MG", value: 0.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1165, name: "Thiamin", number: "404", unitName: "MG",
          value: 0.01, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1166, name: "Riboflavin", number: "405", unitName: "MG",
          value: 0.36, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1167, name: "Niacin", number: "406", unitName: "MG", value: 0.1,
          indentLevel: 1),
        SearchFoodNutrient(
          _id: 1175, name: "Vitamin B-6", number: "415", unitName: "MG",
          value: 0.06, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1177, name: "Folate, total", number: "417", unitName: "UG",
          value: 12.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1178, name: "Vitamin B-12", number: "418", unitName: "UG",
          value: 1.47, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1180, name: "Choline, total", number: "421", unitName: "MG",
          value: 15.4, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1185, name: "Vitamin K (phylloquinone)", number: "430",
          unitName: "UG", value: 1.5, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1186, name: "Folic acid", number: "431", unitName: "UG",
          value: 0.0, indentLevel: 0),
        SearchFoodNutrient(
          _id: 1187, name: "Folate, food", number: "432", unitName: "UG",
          value: 12.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1190, name: "Folate, DFE", number: "435", unitName: "UG",
          value: 12.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1242, name: "Vitamin E, added", number: "573", unitName: "MG",
          value: 0.0, indentLevel: 0),
        SearchFoodNutrient(
          _id: 1246, name: "Vitamin B-12, added", number: "578", unitName: "UG",
          value: 0.0, indentLevel: 0),
        SearchFoodNutrient(
          _id: 1253, name: "Cholesterol", number: "601", unitName: "MG",
          value: 63.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1258, name: "Fatty acids, total saturated", number: "606",
          unitName: "G", value: 11.0, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1259, name: "SFA 4:0", number: "607", unitName: "G",
          value: 0.571, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1260, name: "SFA 6:0", number: "608", unitName: "G",
          value: 0.337, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1261, name: "SFA 8:0", number: "609", unitName: "G",
          value: 0.197, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1262, name: "SFA 10:0", number: "610", unitName: "G",
          value: 0.442, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1263, name: "SFA 12:0", number: "611", unitName: "G",
          value: 0.494, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1264, name: "SFA 14:0", number: "612", unitName: "G",
          value: 1.77, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1265, name: "SFA 16:0", number: "613", unitName: "G",
          value: 4.62, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1266, name: "SFA 18:0", number: "614", unitName: "G",
          value: 2.14, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1268, name: "MUFA 18:1", number: "617", unitName: "G",
          value: 4.42, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1269, name: "PUFA 18:2", number: "618", unitName: "G",
          value: 0.397, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1270, name: "PUFA 18:3", number: "619", unitName: "G",
          value: 0.257, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1271, name: "PUFA 20:4", number: "620", unitName: "G",
          value: 0.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1272, name: "PUFA 22:6 n-3 (DHA)", number: "621", unitName: "G",
          value: 0.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1275, name: "MUFA 16:1", number: "626", unitName: "G",
          value: 0.394, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1276, name: "PUFA 18:4", number: "627", unitName: "G",
          value: 0.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1277, name: "MUFA 20:1", number: "628", unitName: "G",
          value: 0.265, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1278, name: "PUFA 20:5 n-3 (EPA)", number: "629", unitName: "G",
          value: 0.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1279, name: "MUFA 22:1", number: "630", unitName: "G",
          value: 0.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1280, name: "PUFA 22:5 n-3 (DPA)", number: "631", unitName: "G",
          value: 0.0, indentLevel: 2),
        SearchFoodNutrient(
          _id: 1292, name: "Fatty acids, total monounsaturated", number: "645",
          unitName: "G", value: 5.09, indentLevel: 1),
        SearchFoodNutrient(
          _id: 1293, name: "Fatty acids, total polyunsaturated", number: "646",
          unitName: "G", value: 0.65, indentLevel: 1)
      ],
      foodMeasures: [
        SearchFoodMeasure(
          disseminationText: "Quantity not specified", gramWeight: 21,
          id: 269085, rank: 5),
        SearchFoodMeasure(
          disseminationText: "1 cracker-size slice", gramWeight: 9, id: 269081,
          rank: 1),
        SearchFoodMeasure(
          disseminationText: "1 cup, shredded", gramWeight: 113, id: 269083,
          rank: 3),
        SearchFoodMeasure(
          disseminationText: "1 cubic inch", gramWeight: 17.5, id: 269084,
          rank: 4),
        SearchFoodMeasure(
          disseminationText: "1 slice", gramWeight: 21, id: 269082, rank: 2)
      ]
    )
  ]
}
