//
// SPDX-FileCopyrightText: 2016-2023 Robert Tucker
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct FoodsListView: View {
  @Binding var foods: [SearchFoodItem]
  
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

struct FoodsListView_Previews: PreviewProvider {
  static var previews: some View {
    @State var foods = SearchFoodItem.samples
    FoodsListView(foods: $foods)
  }
}
