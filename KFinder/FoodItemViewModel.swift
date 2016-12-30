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
