//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct FoodSearchResult: Codable {
  let totalHits, currentPage, totalPages: Int
  let pageList: [Int]
  let foodSearchCriteria: FoodSearchCriteria
  let foods: [SearchFoodItem]?
}
