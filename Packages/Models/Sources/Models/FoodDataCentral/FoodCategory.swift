// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct FoodCategory: Codable {
  public let code: Int
  public let description: String
  
  public enum CodingKeys: String, CodingKey {
      case code = "wweiaFoodCategoryCode"
      case description = "wweiaFoodCategoryDescription"
  }
}
