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
import UIKit
import RealmSwift

final class AppCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UIViewController
    let childCoordinators: NSMutableArray
    
    var realm: Realm?
    
    init(window: UIWindow) {
        childCoordinators = NSMutableArray()
        rootViewController = UINavigationController()
        
        self.window = window
        self.window.backgroundColor = .white
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()        
    }
    
    func start() {
        configureRealm()
        if let realm = realm {
            let foodSearchCoordinator = FoodSearchCoordinator(rootViewController as! UINavigationController, realm: realm)
            childCoordinators.add(foodSearchCoordinator)
            foodSearchCoordinator.start()
        }
    }
    
    func configureRealm() {
        do {
            realm = try Realm()
        } catch {
            print("Error initializing Realm -> \(error)")
        }
        FoodItem.loadBaseData(realm: realm)
    }
}
