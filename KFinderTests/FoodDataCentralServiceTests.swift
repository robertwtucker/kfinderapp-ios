//
// SPDX-FileCopyrightText: (c) 2026 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation
import Models
import Services
import Testing

// MARK: - URLProtocol stub

// Mocks a single response per request by inspecting the URL. Tests register
// a `MockResponse` before exercising the service; this intercepts the actual
// network call.
struct MockResponse: Sendable {
  let response: HTTPURLResponse
  let data: Data?
  let error: Error?
}

final class MockURLProtocol: URLProtocol, @unchecked Sendable {
  nonisolated(unsafe) static var responder:
    (@Sendable (URLRequest) -> MockResponse)?

  override static func canInit(with request: URLRequest) -> Bool { true }
  override static func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }

  override func startLoading() {
    guard let responder = MockURLProtocol.responder else {
      client?.urlProtocol(
        self,
        didFailWithError: NSError(
          domain: "MockURLProtocol", code: -1,
          userInfo: [NSLocalizedDescriptionKey: "no responder registered"]))
      return
    }
    let mock = responder(request)
    if let error = mock.error {
      client?.urlProtocol(self, didFailWithError: error)
      return
    }
    client?.urlProtocol(
      self, didReceive: mock.response, cacheStoragePolicy: .notAllowed)
    if let data = mock.data {
      client?.urlProtocol(self, didLoad: data)
    }
    client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {}

  static func makeSession() -> URLSession {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: config)
  }
}

// MARK: - fetchFood Tests

@Suite("FoodDataCentralService.fetchFood", .serialized)
struct FoodDataCentralServiceTests {

  private func makeService() -> (FoodDataCentralService, URLSession) {
    let session = MockURLProtocol.makeSession()
    let service = FoodDataCentralService(apiKey: "test-key", session: session)
    return (service, session)
  }

  private func stage(
    status: Int, body: Data?, error: Error? = nil
  ) {
    MockURLProtocol.responder = { request in
      let response = HTTPURLResponse(
        url: request.url!, statusCode: status,
        httpVersion: nil, headerFields: nil)!
      return MockResponse(response: response, data: body, error: error)
    }
  }

  // Minimal payload mirroring the real /food/{id}?format=full shape. Enough
  // surface area to verify the mapping picks up every FoodItem field.
  private func sampleDetailJSON(fdcId: Int = 2_341_130) -> Data {
    let json = """
    {
      "fdcId": \(fdcId),
      "description": "Cheese, Muenster, reduced fat",
      "dataType": "Survey (FNDDS)",
      "foodClass": "Survey",
      "foodCode": "14107250",
      "publicationDate": "10/28/2022",
      "wweiaFoodCategory": {
        "wweiaFoodCategoryCode": 1602,
        "wweiaFoodCategoryDescription": "Cheese"
      },
      "foodAttributes": [
        {"id": 1, "value": "lowfat", "sequenceNumber": 1,
         "foodAttributeType": {"id": 1001, "name": "Additional Description"}},
        {"id": 2, "value": "part skim", "sequenceNumber": 2,
         "foodAttributeType": {"id": 1001, "name": "Additional Description"}},
        {"id": 3, "value": 1602, "name": "WWEIA Category number",
         "foodAttributeType": {"id": 999, "name": "Attribute"}}
      ],
      "foodNutrients": [
        {"type": "FoodNutrient",
         "nutrient": {"id": 2045, "number": "951", "name": "Proximates",
                      "rank": 50, "unitName": "g"}},
        {"type": "FoodNutrient", "id": 28564574, "amount": 24.7,
         "nutrient": {"id": 1003, "number": "203", "name": "Protein",
                      "rank": 600, "unitName": "g"}},
        {"type": "FoodNutrient", "id": 28564601, "amount": 1.5,
         "nutrient": {"id": 1185, "number": "430",
                      "name": "Vitamin K (phylloquinone)",
                      "rank": 8800, "unitName": "ug"}}
      ],
      "foodPortions": [
        {"id": 269081, "gramWeight": 9, "modifier": "1 cracker-size slice",
         "portionDescription": "Quantity not specified", "sequenceNumber": 1},
        {"id": 269083, "gramWeight": 113, "modifier": "1 cup, shredded",
         "portionDescription": "Quantity not specified", "sequenceNumber": 3}
      ]
    }
    """
    return Data(json.utf8)
  }

  @Test("maps a 200 response into a populated FoodItem")
  func mapsSuccess() async throws {
    let (service, _) = makeService()
    stage(status: 200, body: sampleDetailJSON())

    let food = try await service.fetchFood(by: 2_341_130)

    #expect(food.id == 2_341_130)
    #expect(food.name == "Cheese, Muenster, reduced fat")
    #expect(food.dataType == "Survey (FNDDS)")
    #expect(food.category == "Cheese")
    #expect(food.extra == "lowfat;part skim")
    // 3 nutrients in payload, 1 is a category header (no id/amount) → 2 kept.
    #expect(food.nutrients?.count == 2)
    #expect(food.nutrients?.contains { $0.number == "430" } == true)
    #expect(food.measures?.count == 2)
    #expect(food.measures?.first?.text == "1 cracker-size slice")
  }

  @Test("translates 404 into FoodDataCentralError.notFound")
  func translatesNotFound() async throws {
    let (service, _) = makeService()
    stage(status: 404, body: Data())

    await #expect(throws: FoodDataCentralError.notFound) {
      _ = try await service.fetchFood(by: 9_999_999)
    }
  }

  @Test("translates non-success status into unexpectedStatus")
  func translatesUnexpectedStatus() async throws {
    let (service, _) = makeService()
    stage(status: 500, body: Data())

    do {
      _ = try await service.fetchFood(by: 1)
      Issue.record("expected throw")
    } catch FoodDataCentralError.unexpectedStatus(let code) {
      #expect(code == 500)
    } catch {
      Issue.record("unexpected error: \(error)")
    }
  }

  @Test("translates a malformed body into FoodDataCentralError.decoding")
  func translatesDecodingError() async throws {
    let (service, _) = makeService()
    stage(status: 200, body: Data("{ not json".utf8))

    await #expect(throws: FoodDataCentralError.decoding) {
      _ = try await service.fetchFood(by: 1)
    }
  }
}
