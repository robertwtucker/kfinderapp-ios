/**
 * Copyright (c) 2016 Robert Tucker
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
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
