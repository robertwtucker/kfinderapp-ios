//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

enum SearchDataSet: String, Codable {
  case branded = "Branded"
  case foundation = "Foundation"
  case survey = "Survey (FNDDS)"
  case legacy = "SR Legacy"
  case unspecified = ""
}

struct SearchResult: Codable {
  let totalHits, currentPage, totalPages: Int
  let pageList: [Int]
  let foodSearchCriteria: SearchCriteria
  let foods: [SearchFoodItem]?
}

struct SearchCriteria: Codable {
  enum SortBy: String, Codable {
    case datatype = "dataType.keyword"
    case description = "lowercaseDescription.keyword"
    case fdcid = "fdcId"
    case published = "publishedDate"
  }
  
  enum SortOrder: String, Codable {
    case ascending = "asc"
    case descending = "desc"
  }
  
  // Search terms to use in the search. The string may also include standard [search operators](https://fdc.nal.usda.gov/help.html#bkmk-2)
  let query: String
  // Optional. Filter on a specific data type; specify one or more values in an array.
  let dataType: [SearchDataSet]?
  // Optional. Maximum number of results to return for the current page. Default is 50.
  let pageSize: Int?
  // Optional. Page number to retrieve. The offset into the overall result set is expressed as (pageNumber * pageSize)
  let pageNumber: Int?
  // Optional. Specify one of the possible values to sort by that field. Note, dataType.keyword will be dataType and description.keyword will be description in future releases.
  let sortBy: SortBy?
  // Optional. The sort direction for the results. Only applicable if sortBy is specified.
  let sortOrder: SortOrder?
  // Optional. Filter results based on the brand owner of the food. Only applies to Branded Foods.
  let brandOwner: String?
}
