//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct SearchFoodMeasure: Codable, Sendable {
  public let disseminationText: String
  public let gramWeight: Double
  public let id: Int
  public let rank: Int
  
  public var ounceWeight: Double {
    return gramWeight / 28.35
  }
}
