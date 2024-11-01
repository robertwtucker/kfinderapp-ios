//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
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
      print("Error: Missing config variable '\(named)'")
      return nil
    }
    return value
  }
}
