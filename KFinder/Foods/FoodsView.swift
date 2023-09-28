//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import os

enum SearchScope: String, CaseIterable {
  case fdc = "FoodData Central"
  case favorites = "Favorites"
}

struct FoodsView: View {
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: FoodsView.self))
  
  @State private var model = FoodSearchModel()
  @State private var searchScope = SearchScope.fdc
  @State private var isSearching = false
  
  var body: some View {
    NavigationStack {
      FoodsListView(foods: $model.foods)
        .navigationTitle("Foods")
    }
    .overlay {
      if isSearching {
        LoadingView()
      }
    }
    .searchable(text: $model.query, prompt: "Food name or keywords")
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
        logger.debug("dispatching FDC search for '\(model.query)'")
        Task {
          isSearching.toggle()
          await model.loadAsync()
          isSearching.toggle()
        }
      case .favorites:
        logger.debug("searching Favorites for '\(model.query)'")
        // TODO: Implement Favorites
      }
    }
  }
}

struct FoodsView_Previews: PreviewProvider {
  static var previews: some View {
    FoodsView()
  }
}
