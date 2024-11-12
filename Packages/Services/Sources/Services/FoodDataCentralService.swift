//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Models
import os

public struct FoodDataCentralService {
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodDataCentralService.self))

  private let apiKey: String
  private let apiKeyHeader = "X-Api-Key"
  private let baseURL = URL(string: "https://api.nal.usda.gov/fdc/v1")

  public init(apiKey: String) {
    self.apiKey = apiKey
  }

  public func searchFoods(for query: String) async -> FoodSearchResult? {
    let request = buildSearchURLRequest(
      with: query.trimmingCharacters(in: [" "]))

    do {
      logger.debug("\(request.httpMethod!) \(request.url!)")
      let (data, _) = try await URLSession.shared.data(for: request)
      let result = try JSONDecoder().decode(FoodSearchResult.self, from: data)
      logger.debug("search returned with \(result.totalHits) hit(s)")
      return result
    } catch {
      logger.error("\(error, privacy: .public)")
    }
    return nil
  }

  private func buildSearchURLRequest(with query: String) -> URLRequest {
    let encodedQuery =
      query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let dataTypes = "\(FoodSearchCriteria.DataSet.survey.rawValue)"
    let url = baseURL!.appending(path: "/foods/search")
    let queryItems = [
      URLQueryItem(name: "dataType", value: dataTypes),
      URLQueryItem(
        name: "sortBy", value: FoodSearchCriteria.SortBy.description.rawValue),
      URLQueryItem(
        name: "sortOrder",
        value: FoodSearchCriteria.SortOrder.ascending.rawValue),
      URLQueryItem(name: "requireAllWords", value: "false"),
      URLQueryItem(name: "query", value: encodedQuery)
    ]
    var request = URLRequest(url: url.appending(queryItems: queryItems))
    request.httpMethod = "GET"
    request.setValue(apiKey, forHTTPHeaderField: apiKeyHeader)
    return request
  }

  private func buildFoodURLRequest(with id: Int) -> URLRequest {
    var url = baseURL!.appending(path: "/food/\(id)")
    url = url.appending(queryItems: [
      URLQueryItem(name: "format", value: "full")
    ])
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(apiKey, forHTTPHeaderField: apiKeyHeader)
    return request
  }
}
