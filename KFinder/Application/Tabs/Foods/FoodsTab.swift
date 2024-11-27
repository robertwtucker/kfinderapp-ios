//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import DesignSystem
import OSLog
import SwiftUI
import TelemetryDeck

enum SearchScope: String, CaseIterable {
  case fdc = "FoodData Central"
  case favorites = "Favorites"
}

struct FoodsTab: View {
  @Bindable private var helper = FoodSearchHelper()
  @State private var searchScope = SearchScope.fdc
  @State private var shouldShowHowToStart = true

  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodsTab.self))

  var body: some View {
    NavigationStack {
      FoodsListView(foods: helper.foods)
    }
    .overlay {
      if shouldShowHowToStart {
        ContentUnavailableView {
          Label("foods.search.init", systemImage: "magnifyingglass")
        } description: {
          Text("foods.search.description")
        }
      } else {
        if helper.foods.isEmpty && helper.query.count >= 3 {
          ContentUnavailableView.search
        }
      }
    }
    .searchable(text: $helper.query, prompt: "foods.search.prompt")
    // TODO: Implement Favorites  //swiftlint:disable:this todo
    //    .searchScopes($searchScope) {
    //      ForEach(SearchScope.allCases, id: \.self) { scope in
    //        Text(scope.rawValue)
    //      }
    //    }
    .autocapitalization(.none)
    .disableAutocorrection(true)
    .task(id: helper.query, {
      guard helper.query.count >= 3 else { return }
      shouldShowHowToStart = false
      await helper.search()
    })
  }
}
