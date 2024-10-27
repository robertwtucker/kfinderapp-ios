//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct SurveyFoodItem: Codable, Sendable {
    public let fdcId: Int
    public let dataType: String
    public let description: String
    public let foodNutrients: [FoodNutrient]?
    public let foodClass: String?
    public let foodCode: String?
    public let publicationDate: String?
    public let foodCategory: FoodCategory?
    public let foodPortions: [FoodPortion]?

    public enum CodingKeys: String, CodingKey {
        case foodCategory = "wweiaFoodCategory"
        case fdcId, dataType, description, foodNutrients, foodClass, foodCode, publicationDate, foodPortions
    }
  
  public init(fdcId: Int, dataType: String, description: String, foodNutrients: [FoodNutrient]? = nil, foodClass: String? = nil, foodCode: String? = nil, publicationDate: String? = nil, foodCategory: FoodCategory? = nil, foodPortions: [FoodPortion]? = nil) {
    self.fdcId = fdcId
    self.dataType = dataType
    self.description = description
    self.foodNutrients = foodNutrients
    self.foodClass = foodClass
    self.foodCode = foodCode
    self.publicationDate = publicationDate
    self.foodCategory = foodCategory
    self.foodPortions = foodPortions
  }
}

// MARK: - Samples
public extension SurveyFoodItem {
  static let empty = SurveyFoodItem(fdcId: 0, dataType: "", description: "")
  static let sample = SurveyFoodItem(
    fdcId: 2345430,
    dataType: "Survey (FNDDS)",
    description: "Fennel bulb, cooked",
    foodNutrients: [
      FoodNutrient(_id: 28844074, nutrient: Nutrient(id: 1003, number: "203", name: "Protein", unitName: .g), amount: 1.42),
      FoodNutrient(_id: 28844075, nutrient: Nutrient(id: 1004, number: "204", name: "Total lipid (fat)", unitName: .g), amount: 3.22),
      FoodNutrient(_id: 28844076, nutrient: Nutrient(id: 1005, number: "205", name: "Carbohydrate, by difference", unitName: .g), amount: 8.32),
      FoodNutrient(_id: 28844077, nutrient: Nutrient(id: 1008, number: "208", name: "Energy", unitName: .kcal), amount: 62.0),
      FoodNutrient(_id: 28844078, nutrient: Nutrient(id: 1018, number: "221", name: "Alcohol, ethyl", unitName: .g), amount: 0.0),
      FoodNutrient(_id: 28844079, nutrient: Nutrient(id: 1051, number: "255", name: "Water", unitName: .g), amount: 85.5),
      FoodNutrient(_id: 28844080, nutrient: Nutrient(id: 1057, number: "262", name: "Caffeine", unitName: .mg), amount: 0.0),
      FoodNutrient(_id: 28844081, nutrient: Nutrient(id: 1058, number: "263", name: "Theobromine", unitName: .mg), amount: 0.0),
      FoodNutrient(_id: 28844082, nutrient: Nutrient(id: 2000, number: "269", name: "Sugars, total including NLEA", unitName: .g), amount: 4.48),
      FoodNutrient(_id: 28844083, nutrient: Nutrient(id: 1079, number: "291", name: "Fiber, total dietary", unitName: .g), amount: 3.5),
      FoodNutrient(_id: 28844084, nutrient: Nutrient(id: 1087, number: "301", name: "Calcium, Ca", unitName: .mg), amount: 56.0),
      FoodNutrient(_id: 28844085, nutrient: Nutrient(id: 1089, number: "303", name: "Iron, Fe", unitName: .mg), amount: 0.84),
      FoodNutrient(_id: 28844086, nutrient: Nutrient(id: 1090, number: "304", name: "Magnesium, Mg", unitName: .mg), amount: 19.0),
      FoodNutrient(_id: 28844087, nutrient: Nutrient(id: 1091, number: "305", name: "Phosphorus, P", unitName: .mg), amount: 57.0),
      FoodNutrient(_id: 28844088, nutrient: Nutrient(id: 1092, number: "306", name: "Potassium, K", unitName: .mg), amount: 472),
      FoodNutrient(_id: 28844089, nutrient: Nutrient(id: 1093, number: "307", name: "Sodium, Na", unitName: .mg), amount: 202),
      FoodNutrient(_id: 28844090, nutrient: Nutrient(id: 1095, number: "309", name: "Zinc, Zn", unitName: .mg), amount: 0.23),
      FoodNutrient(_id: 28844091, nutrient: Nutrient(id: 1098, number: "312", name: "Copper, Cu", unitName: .mg), amount: 0.075),
      FoodNutrient(_id: 28844092, nutrient: Nutrient(id: 1103, number: "317", name: "Selenium, Se", unitName: .µg), amount: 0.8),
      FoodNutrient(_id: 28844093, nutrient: Nutrient(id: 1105, number: "319", name: "Retinol", unitName: .µg), amount: 13.0),
      FoodNutrient(_id: 28844094, nutrient: Nutrient(id: 1106, number: "320", name: "Vitamin A, RAE", unitName: .µg), amount: 65.0),
      FoodNutrient(_id: 28844095, nutrient: Nutrient(id: 1107, number: "321", name: "Carotene, beta", unitName: .µg), amount: 631),
      FoodNutrient(_id: 28844096, nutrient: Nutrient(id: 1108, number: "322", name: "Carotene, alpha", unitName: .µg), amount: 0.0),
      FoodNutrient(_id: 28844097, nutrient: Nutrient(id: 1109, number: "323", name: "Vitamin E (alpha-tocopherol)", unitName: .mg), amount: 1.06),
      FoodNutrient(_id: 28844098, nutrient: Nutrient(id: 1114, number: "328", name: "Vitamin D (D2 + D3)", unitName: .µg), amount: 0.0),
      FoodNutrient(_id: 28844099, nutrient: Nutrient(id: 1120, number: "334", name: "Cryptoxanthin, beta", unitName: .µg), amount: 0.0),
      FoodNutrient(_id: 28844100, nutrient: Nutrient(id: 1122, number: "337", name: "Lycopene", unitName: .µg), amount: 0.0),
      FoodNutrient(_id: 28844101, nutrient: Nutrient(id: 1123, number: "338", name: "Lutein + zeaxanthin", unitName: .µg), amount: 657),
      FoodNutrient(_id: 28844102, nutrient: Nutrient(id: 1162, number: "401", name: "Vitamin C, total ascorbic acid", unitName: .mg), amount: 11.6),
      FoodNutrient(_id: 28844103, nutrient: Nutrient(id: 1165, number: "404", name: "Thiamin", unitName: .mg), amount: 0.01),
      FoodNutrient(_id: 28844104, nutrient: Nutrient(id: 1166, number: "405", name: "Riboflavin", unitName: .mg), amount: 0.035),
      FoodNutrient(_id: 28844105, nutrient: Nutrient(id: 1167, number: "406", name: "Niacin", unitName: .mg), amount: 0.693),
      FoodNutrient(_id: 28844106, nutrient: Nutrient(id: 1175, number: "415", name: "Vitamin B-6", unitName: .mg), amount: 0.067),
      FoodNutrient(_id: 28844107, nutrient: Nutrient(id: 1177, number: "417", name: "Folate, total", unitName: .µg), amount: 26.0),
      FoodNutrient(_id: 28844108, nutrient: Nutrient(id: 1178, number: "418", name: "Vitamin B-12", unitName: .µg), amount: 0.0),
      FoodNutrient(_id: 28844109, nutrient: Nutrient(id: 1180, number: "421", name: "Choline, total", unitName: .mg), amount: 15.3),
      FoodNutrient(_id: 28844110, nutrient: Nutrient(id: 1185, number: "430", name: "Vitamin K (phylloquinone)", unitName: .µg), amount: 74.1),
      FoodNutrient(_id: 28844111, nutrient: Nutrient(id: 1186, number: "431", name: "Folic acid", unitName: .µg), amount: 0.0),
      FoodNutrient(_id: 28844112, nutrient: Nutrient(id: 1187, number: "432", name: "Folate, food", unitName: .µg), amount: 26.0),
      FoodNutrient(_id: 28844113, nutrient: Nutrient(id: 1190, number: "435", name: "Folate, DFE", unitName: .µg), amount: 26.0),
      FoodNutrient(_id: 28844114, nutrient: Nutrient(id: 1242, number: "573", name: "Vitamin E, added", unitName: .mg), amount: 0.0),
      FoodNutrient(_id: 28844115, nutrient: Nutrient(id: 1246, number: "578", name: "Vitamin B-12, added", unitName: .µg), amount: 0.0),
      FoodNutrient(_id: 28844116, nutrient: Nutrient(id: 1253, number: "601", name: "Cholesterol", unitName: .mg), amount: 2.0),
      FoodNutrient(_id: 28844117, nutrient: Nutrient(id: 1258, number: "606", name: "Fatty acids, total saturated", unitName: .g), amount: 0.891),
      FoodNutrient(_id: 28844118, nutrient: Nutrient(id: 1259, number: "607", name: "SFA 4:0", unitName: .g), amount: 0.021),
      FoodNutrient(_id: 28844119, nutrient: Nutrient(id: 1260, number: "608", name: "SFA 6:0", unitName: .g), amount: 0.015),
      FoodNutrient(_id: 28844120, nutrient: Nutrient(id: 1261, number: "609", name: "SFA 8:0", unitName: .g), amount: 0.009),
      FoodNutrient(_id: 28844121, nutrient: Nutrient(id: 1262, number: "610", name: "SFA 10:0", unitName: .g), amount: 0.02),
      FoodNutrient(_id: 28844122, nutrient: Nutrient(id: 1263, number: "611", name: "SFA 12:0", unitName: .g), amount: 0.024),
      FoodNutrient(_id: 28844123, nutrient: Nutrient(id: 1264, number: "612", name: "SFA 14:0", unitName: .g), amount: 0.077),
      FoodNutrient(_id: 28844124, nutrient: Nutrient(id: 1265, number: "613", name: "SFA 16:0", unitName: .g), amount: 0.523),
      FoodNutrient(_id: 28844125, nutrient: Nutrient(id: 1266, number: "614", name: "SFA 18:0", unitName: .g), amount: 0.171),
      FoodNutrient(_id: 28844126, nutrient: Nutrient(id: 1268, number: "617", name: "MUFA 18:1", unitName: .g), amount: 1.06),
      FoodNutrient(_id: 28844127, nutrient: Nutrient(id: 1269, number: "618", name: "PUFA 18:2", unitName: .g), amount: 0.982),
      FoodNutrient(_id: 28844128, nutrient: Nutrient(id: 1270, number: "619", name: "PUFA 18:3", unitName: .g), amount: 0.101),
      FoodNutrient(_id: 28844129, nutrient: Nutrient(id: 1271, number: "620", name: "PUFA 20:4", unitName: .g), amount: 0.001),
      FoodNutrient(_id: 28844130, nutrient: Nutrient(id: 1272, number: "621", name: "PUFA 22:6 n-3 (DHA)", unitName: .g), amount: 0.0),
      FoodNutrient(_id: 28844131, nutrient: Nutrient(id: 1275, number: "626", name: "MUFA 16:1", unitName: .g), amount: 0.019),
      FoodNutrient(_id: 28844132, nutrient: Nutrient(id: 1276, number: "627", name: "PUFA 18:4", unitName: .g), amount: 0.0),
      FoodNutrient(_id: 28844133, nutrient: Nutrient(id: 1277, number: "628", name: "MUFA 20:1", unitName: .g), amount: 0.014),
      FoodNutrient(_id: 28844134, nutrient: Nutrient(id: 1278, number: "629", name: "PUFA 20:5 n-3 (EPA)", unitName: .g), amount: 0.0),
      FoodNutrient(_id: 28844135, nutrient: Nutrient(id: 1279, number: "630", name: "MUFA 22:1", unitName: .g), amount: 0.0),
      FoodNutrient(_id: 28844136, nutrient: Nutrient(id: 1280, number: "631", name: "PUFA 22:5 n-3 (DPA)", unitName: .g), amount: 0.0),
      FoodNutrient(_id: 28844137, nutrient: Nutrient(id: 1292, number: "645", name: "Fatty acids, total monounsaturated", unitName: .g), amount: 1.1),
      FoodNutrient(_id: 28844138, nutrient: Nutrient(id: 1293, number: "646", name: "Fatty acids, total polyunsaturated", unitName: .g), amount: 1.08)
    ],
    foodClass: "Survey",
    foodCode: "75215120",
    publicationDate: "10/28/2022",
    foodCategory: FoodCategory(code: 2650531, description: "Other vegetables and combinations"),
    foodPortions: [
      FoodPortion(id: 286407, gramWeight: 78, sequenceNumber: 2, portionDescription: "Quantity not specified"),
      FoodPortion(id: 286406, gramWeight: 218, sequenceNumber: 1, portionDescription: "1 fennel bulb")
    ])
}
