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

import CSV
import RealmSwift

extension FoodItem {

    enum DataField: String {
        case id = "id"
        case name = "name"
        case weight = "weight"
        case measure = "measure"
        case k = "k"
    }

    static func loadBaseData(realm: Realm? = try? Realm()) {

        guard let realm = realm else {
            print("Error: Realm not available to load data")
            return
        }

        //TODO: Remove after testing load options
//        defaults.set(false, forKey: dataInitKey)
//        try! realm.write {
//            realm.delete(realm.objects(FoodItem.self))
//        }

        guard AppSettings.sharedState.baseDataLoaded == false else {
            return
        }

        guard let dataFileURL = Bundle.main.url(forResource: "kdata", withExtension: "csv") else {
            print("Error: Unable to locate data file")
            return
        }

        guard let stream = InputStream(url: dataFileURL) else {
            return
        }

        do {
            var csv = try CSV(stream: stream, hasHeaderRow: true, trimFields: false, delimiter: ",")

            realm.beginWrite()

            while let _ = csv.next() {
                guard
                    let id = Int(csv[DataField.id.rawValue]!),
                    let name = csv[DataField.name.rawValue],
                    let weight = Float(csv[DataField.weight.rawValue]!),
                    let measure = csv[DataField.measure.rawValue],
                    let k = Float(csv[DataField.k.rawValue]!)
                    else {
                        print("Error: Invalid record in data file -> \(csv)")
                        continue
                }

                let foodItem = FoodItem(id: id, name: name, weight: weight, measure: measure, k: k)
                realm.add(foodItem)
            }
        } catch {
            print("Error parsing the data file -> \(error)")
        }

        do {
            _ = try realm.commitWrite()
        } catch {
            print("Error saving data records -> \(error)")
        }
        UserDefaults.standard.set(true, forKey: "baseDataLoaded")
    }

}
