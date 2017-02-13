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

import RealmSwift

class FoodItem: Object {

    //MARK: Properties

    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var weight: Double = 0.0
    dynamic var measure: String = ""
    dynamic var k: Double = 0.0


    //MARK: Initialization

    convenience init(id: Int, name: String, weight: Double, measure: String, k: Double) {
        self.init()
        self.id = id
        self.name = name
        self.weight = weight
        self.measure = measure
        self.k = k
    }


    //MARK: - Class Functions

    override class func primaryKey() -> String? {
        return "id"
    }

    override static func indexedProperties() -> [String] {
        return ["name"]
    }

}
