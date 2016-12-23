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

import Foundation
import CoreData
import CSV

extension CoreDataStack {
    
    func loadDataFirstTime() {
        let defaults = UserDefaults.standard
        guard (defaults.bool(forKey: "firstTimeDataLoaded") == false) else {
            return
        }
        
        guard let dataFileURL = Bundle.main.url(forResource: "kdata", withExtension: "csv") else {
            print("Error: Unable to locate data file")
            return
        }
        
        if let stream = InputStream(url: dataFileURL) {
            var csv = try! CSV(stream: stream, hasHeaderRow: true, trimFields: false, delimiter: ",")
            while let _ = csv.next() {
                guard
                    let id = Int32(csv["id"]!),
                    let name = csv["name"],
                    let weight = Float(csv["weight"]!),
                    let measure = csv["measure"],
                    let k = Float(csv["k"]!)
                    else {
                        print("Error: Invalid record in data file -> \(csv)")
                        continue
                }
                
                let foodItem = FoodItem(context: getContext())
                foodItem.id = id
                foodItem.name = name
                foodItem.weight = weight
                foodItem.measure = measure
                foodItem.k = k
            }
            saveContext()
        }
        defaults.set(true, forKey: "firstTimeDataLoaded")
    }
    
}
