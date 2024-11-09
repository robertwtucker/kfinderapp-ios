//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import SwiftUI

extension UIApplication {
  // swiftlint:disable force_cast
  static var release: String {
    return Bundle.main.object(
      forInfoDictionaryKey: "CFBundleShortVersionString") as! String?
      ?? "unknown"
  }
  static var build: String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
      as! String? ?? "unknown"
  }
  // swiftlint:enable force_cast
  static var version: String {
    return "\(release) (\(build))"
  }
}
