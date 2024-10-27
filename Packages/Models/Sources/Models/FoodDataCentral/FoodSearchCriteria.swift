//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct FoodSearchCriteria: Codable, Sendable {
  public enum DataSet: String, Codable, Sendable {
    case branded = "Branded"
    case foundation = "Foundation"
    case survey = "Survey (FNDDS)"
    case legacy = "SR Legacy"
    case unspecified = ""
  }
  
  public enum SortBy: String, Codable, Sendable {
    case datatype = "dataType.keyword"
    case description = "lowercaseDescription.keyword"
    case fdcid = "fdcId"
    case published = "publishedDate"
  }
  
  public enum SortOrder: String, Codable, Sendable {
    case ascending = "asc"
    case descending = "desc"
  }
  
  // Search terms to use in the search. The string may also include standard [search operators](https://fdc.nal.usda.gov/help.html#bkmk-2)
  public let query: String
  // Optional. Filter on a specific data type; specify one or more values in an array.
  public let dataType: [DataSet]?
  // Optional. Maximum number of results to return for the current page. Default is 50.
  public let pageSize: Int?
  // Optional. Page number to retrieve. The offset into the overall result set is expressed as (pageNumber * pageSize)
  public let pageNumber: Int?
  // Optional. Specify one of the possible values to sort by that field. Note, dataType.keyword will be dataType and description.keyword will be description in future releases.
  public let sortBy: SortBy?
  // Optional. The sort direction for the results. Only applicable if sortBy is specified.
  public let sortOrder: SortOrder?
  // Optional. Filter results based on the brand owner of the food. Only applies to Branded Foods.
  public let brandOwner: String?
}
