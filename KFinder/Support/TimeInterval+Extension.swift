//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation

extension TimeInterval {
  static let minute: TimeInterval = 60
  static let hour: TimeInterval = 60 * TimeInterval.minute
  static let day: TimeInterval = 24 * TimeInterval.hour
  static let week: TimeInterval = 7 * TimeInterval.day
}
