//
// SPDX-FileCopyrightText: (c) 2024 Robert Tucker
// SPDX-License-Identifier: MIT
//

import DesignSystem
import OSLog
import SwiftUI

enum SearchScope: String, CaseIterable {
  case fdc = "FoodData Central"
  case favorites = "Favorites"
}

struct FoodsTab: View {
  @Bindable private var helper = FoodSearchHelper()
  @State private var searchScope = SearchScope.fdc
  @State private var isSearching = false
  @State private var searchCount = 0

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
    .overlay {
      if searchCount == 0 {
        ContentUnavailableView {
          Label("foods.search.init", systemImage: "magnifyingglass")
        } description: {
          Text("foods.search.description")
        }
      } else {
        if helper.foods.isEmpty && !isSearching {
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
    .onSubmit(of: .search) {
      switch searchScope {
      case .fdc:
        logger.debug("Dispatching FDC search for '\(helper.query)'")
        Task {
          isSearching.toggle()
          searchCount += 1
          await helper.search()
          isSearching.toggle()
        }
      case .favorites:
        // TODO: Implement Favorites  //swiftlint:disable:this todo
        logger.debug("Searching Favorites for '\(helper.query)'")
      }
    }
  }
}
