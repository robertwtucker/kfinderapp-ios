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

struct FoodItemViewModel {

    //MARK: Properties

    let foodItem: FoodItem

    var id: Int { return foodItem.id }
    var name: String { return foodItem.name }
    var weight: String { return "\(foodItem.weight) g" }
    var measure: String { return foodItem.measure }
    var k: String { return "\(foodItem.k) mcg" }
    var title: String {
        if !name.isEmpty, let comma = name.characters.index(of: ",") {
            return name.substring(to: comma)
        } else {
            return name
        }
    }


    //MARK: Initialization

    init(_ foodItem: FoodItem) {
        self.foodItem = foodItem
    }

}
