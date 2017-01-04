/**
 * Copyright 2017 Robert Tucker
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import RxSwift
import RealmSwift

struct FoodItemCellViewModel {

    //MARK: Properties

    let foodItem: FoodItem

    var name: String { return foodItem.name }
    var description: String { return "\(foodItem.measure) - \(foodItem.k) mcg" }


    //MARK: Initialization

    init(foodItem: FoodItem) {
        self.foodItem = foodItem
    }
}


//MARK: - Extensions

extension Observable {
    func mapToFoodItemCellViewModels() -> Observable<[FoodItemCellViewModel]> {
        return self.map { foodItems in
            if let foodItems = foodItems as? Results<FoodItem> {
                return foodItems.map { return FoodItemCellViewModel(foodItem: $0) }
            } else {
                return []
            }
        }
    }
}
