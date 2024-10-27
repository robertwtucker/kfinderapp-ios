//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

@MainActor
@Observable public class UserPreferences {
  class Storage {
    @AppStorage("k_target") public var kTarget: Double = 120
  }
  
  public static let shared = UserPreferences()
  private let storage = Storage()
  
  public var kTarget: Double {
    didSet {
      storage.kTarget = kTarget
    }
  }
  
  private init() {
    kTarget = storage.kTarget
  }
}
