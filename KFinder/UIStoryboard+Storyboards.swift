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

import UIKit

// Eliminating string literals to make storyboard identifiers predictable
// See: https://medium.com/swift-programming/uistoryboard-safer-with-enums-protocol-extensions-and-generics-7aad3883b44d#.u5mer0bhc

extension UIStoryboard {

    // The one place where all of the app's storyboards are listed

    enum Storyboard: String {
        case main
        case settings

        var filename: String {
            return rawValue.capitalized
        }
    }


    //MARK: Initialization

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }


    //MARK: - Class Functions

    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }


    //MARK: - View Controller Instantiation from Generics

    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }

        return viewController
    }
}
