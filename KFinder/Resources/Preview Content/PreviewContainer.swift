//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import Models
import SwiftData

#if DEBUG
  @MainActor
  let previewContainer: ModelContainer = {
    do {
      let container = try ModelContainer(
        for: FoodItem.self, configurations: .init(isStoredInMemoryOnly: true))
      for sample in FoodItem.samples {
        container.mainContext.insert(sample)
      }
      return container
    } catch {
      fatalError("Failed to create preview container")
    }
  }()
#endif
