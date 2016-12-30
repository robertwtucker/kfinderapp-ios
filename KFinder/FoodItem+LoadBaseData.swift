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
        let dataInitKey = "baseDataLoaded"
        let defaults = UserDefaults.standard

        guard let realm = realm else {
            print("Error: Realm not available to load data")
            return
        }
        
        //TODO: Remove after testing load options
//        defaults.set(false, forKey: dataInitKey)
//        try! realm.write {
//            realm.delete(realm.objects(FoodItem.self))
//        }
        
        guard defaults.bool(forKey: dataInitKey) == false else {
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
        defaults.set(true, forKey: dataInitKey)
    }
    
}
