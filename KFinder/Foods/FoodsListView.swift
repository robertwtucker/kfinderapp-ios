//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodsListView: View {
  let foods: [SearchFoodItem]
  
  init(with foods: [SearchFoodItem]) {
    self.foods = foods
  }
  
  var body: some View {
    List(foods) { food in
      NavigationLink(value: food) {
        FoodsListCellView(for: food)
      }
    }
    .navigationDestination(for: SearchFoodItem.self) { food in
      FoodDetailView(food)
    }
  }
}

struct FoodsListView_Previews: PreviewProvider {
  static var previews: some View {
    FoodsListView(with: SearchFoodItem.samples)
  }
}
