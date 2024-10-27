//
// SPDX-FileCopyrightText: 2016-2024 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI
import Models

struct FoodsListView: View {
  var foods: [SearchFoodItem]
  
  var body: some View {
    List(foods) { food in
      NavigationLink(value: food) {
        FoodsListCellView(food: food)
      }
    }
    .navigationDestination(for: SearchFoodItem.self) { food in
      FoodDetailView(food: food)
    }
  }
}

#Preview {
  FoodsListView(foods: SearchFoodItem.samples)
}
