//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Models
import os

public enum FoodDataCentralError: Error, Equatable, Sendable {
  case notFound
  case unexpectedStatus(Int)
  case decoding
  case transport
}

public struct FoodDataCentralService {
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodDataCentralService.self))

  private let apiKey: String
  private let session: URLSession
  private let apiKeyHeader = "X-Api-Key"
  private let baseURL = URL(string: "https://api.nal.usda.gov/fdc/v1")

  // `session` is injectable so tests can intercept via URLProtocol; the
  // default points at the shared session (production behavior unchanged).
  public init(apiKey: String, session: URLSession = .shared) {
    self.apiKey = apiKey
    self.session = session
  }

  public func searchFoods(for query: String) async -> FoodSearchResult? {
    let request = buildSearchURLRequest(
      with: query.trimmingCharacters(in: [" "]))

    do {
      logger.debug("\(request.httpMethod!) \(request.url!)")
      let (data, _) = try await session.data(for: request)
      let result = try JSONDecoder().decode(FoodSearchResult.self, from: data)
      logger.debug("search returned with \(result.totalHits) hit(s)")
      return result
    } catch {
      logger.error("\(error, privacy: .public)")
    }
    return nil
  }

  // Re-hydrates a `RecentFood` into a fully-populated `FoodItem` by hitting
  // /food/{fdcId}?format=full. Unlike `searchFoods`, the failure modes here
  // are exceptional (the caller has an fdcId they expect to resolve), so
  // errors throw rather than silently returning nil. See issue #96.
  public func fetchFood(by fdcId: Int) async throws -> FoodItem {
    let request = buildFoodURLRequest(with: fdcId)
    logger.debug("\(request.httpMethod!) \(request.url!)")

    let data: Data
    let response: URLResponse
    do {
      (data, response) = try await session.data(for: request)
    } catch {
      logger.error("fetchFood transport error: \(error, privacy: .public)")
      throw FoodDataCentralError.transport
    }

    if let status = (response as? HTTPURLResponse)?.statusCode {
      if status == 404 { throw FoodDataCentralError.notFound }
      guard (200..<300).contains(status) else {
        logger.error("fetchFood unexpected status: \(status)")
        throw FoodDataCentralError.unexpectedStatus(status)
      }
    }

    do {
      let detail = try JSONDecoder().decode(
        FoodDetailResponse.self, from: data)
      return FoodItem(from: detail)
    } catch {
      logger.error("fetchFood decoding error: \(error, privacy: .public)")
      throw FoodDataCentralError.decoding
    }
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
