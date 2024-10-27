//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct FoodSearchResult: Codable, Sendable {
  public let totalHits, currentPage, totalPages: Int
  public let pageList: [Int]
  public let foodSearchCriteria: FoodSearchCriteria
  public let foods: [SearchFoodItem]?
}
