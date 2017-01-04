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
import RxCocoa
import RealmSwift
import RxRealm

struct FoodSearchViewModel {

    //MARK: Properties

    // Input
    var searchText = Variable("")
//    var selectedFoodItem = PublishSubject<FoodItem>()
    var selectedModel = PublishSubject<FoodItemCellViewModel>()

    // Output
    let navigationBarTitle: Observable<String>
    let searchResults: Observable<[FoodItemCellViewModel]>
    let selectedFoodItemViewModel: Observable<FoodItemViewModel>


    //MARK: Initialization

    init(realm: Realm) {
        let foodItemsObservable = Observable.from(realm.objects(FoodItem.self))

        navigationBarTitle = .just("Foods")

        searchResults = searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { $0.characters.count > 0 }
            .withLatestFrom(foodItemsObservable) { query, foodItems in
                foodItems.filter("name CONTAINS[c] %@", query)
            }
            .mapToFoodItemCellViewModels()
            .observeOn(MainScheduler.instance)

        selectedFoodItemViewModel = selectedModel
            .map { FoodItemViewModel($0.foodItem) }
            .shareReplay(1)
    }

}
