//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation

extension Formatter {
  public static let dueDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .autoupdatingCurrent
    formatter.timeStyle = .none
    formatter.dateStyle = .short
    return formatter
  }()
}
