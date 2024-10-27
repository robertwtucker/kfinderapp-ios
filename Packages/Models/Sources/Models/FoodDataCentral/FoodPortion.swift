//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct FoodPortion: Codable, Sendable {
    public let id: Int
    public let gramWeight: Int
    public let sequenceNumber: Int
    public let portionDescription: String
}
