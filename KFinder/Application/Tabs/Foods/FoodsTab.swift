//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import OSLog

enum SearchScope: String, CaseIterable {
  case fdc = "FoodData Central"
  case favorites = "Favorites"
}

struct FoodsTab: View {
  @Bindable private var helper = FoodSearchHelper()
  @State private var searchScope = SearchScope.fdc
  @State private var isSearching = false
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodsTab.self))
  
  var body: some View {
    NavigationStack {
      FoodsListView(foods: helper.foods)
    }
    .overlay {
      if isSearching {
        LoadingView()
      }
    }
    .searchable(text: $helper.query, prompt: "foods.search.prompt")
    // TODO: Implement Favorites
//    .searchScopes($searchScope) {
//      ForEach(SearchScope.allCases, id: \.self) { scope in
//        Text(scope.rawValue)
//      }
//    }
    .autocapitalization(.none)
    .disableAutocorrection(true)
    .onSubmit(of: .search) {
      switch searchScope {
      case .fdc:
        logger.debug("Dispatching FDC search for '\(helper.query)'")
        Task {
          isSearching.toggle()
          await helper.search()
          isSearching.toggle()
        }
      case .favorites:
        logger.debug("Searching Favorites for '\(helper.query)'")
        // TODO: Implement Favorites
      }
    }
  }
}
