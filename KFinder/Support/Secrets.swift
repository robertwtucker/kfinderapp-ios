//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Foundation

enum Secrets {
  enum FoodDataCentral {
    static let apiKey = Secrets.configVariable(named: "FDC_API_KEY")
  }

  fileprivate static func configVariable(named: String) -> String? {
    guard let infoDictionary = Bundle.main.infoDictionary else {
      return nil
    }
    guard let value = infoDictionary[named] as? String else {
      return nil
    }
    return value
  }
}
