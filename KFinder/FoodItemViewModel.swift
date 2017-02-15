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

struct FoodItemViewModel {

    //MARK: Properties

    // Output
    var id: Observable<Int>
    var name: Observable<String>
    var weight: Observable<Double>
    var measure: Observable<String>
    var k: Observable<String>
    var title: Observable<String>
    var formattedWeight: Observable<String>


    //MARK: Initialization

    init(_ foodItem: FoodItem) {
        
        id = Observable.from(foodItem.id)
        name = Observable.from(foodItem.name)
        weight = Observable.from(foodItem.weight)
        measure = Observable.from(foodItem.measure)

        k = Observable.from(foodItem.k)
            .map { String(format: "%.1f mcg", $0) }
        
        title = Observable.from(foodItem.name)
            .map {
                if !$0.isEmpty, let comma = $0.characters.index(of: ",") {
                    return $0.substring(to: comma)
                } else {
                    return $0
                }
            }
        
        formattedWeight = AppSettings.sharedState.convertFromMetric.asObservable()
            .withLatestFrom(weight) { convert, value in
                guard let convert = convert else {
                    return String(format: "%.1f g", value)
                }
                if convert {
                    return String(format: "%.1f oz", value * 0.035274)
                } else {
                    return String(format: "%.1f g", value)
                }
            }

    }

}
