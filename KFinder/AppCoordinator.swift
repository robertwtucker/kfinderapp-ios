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

import Foundation
import UIKit
import RealmSwift

enum AppTabs: String, RawRepresentable {
    case Home = "Home"
    case Search = "Search"
    case Settings = "Settings"
}

final class AppCoordinator: TabBarCoordinator {
    let tabBarController: UITabBarController
    var tabCoordinators: Array<TabCoordinator>

    init(window: UIWindow) {
        tabCoordinators = Array<TabCoordinator>()
        tabBarController = UITabBarController()

        window.backgroundColor = .white
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    func start() {
        FoodItem.loadBaseData(realm: RealmProvider.appRealm)
        
        createTabControllers()

        var tabViewControllers = Array<UIViewController>()
        for tabCoordinator in tabCoordinators {
            tabCoordinator.start()
            tabViewControllers.append(tabCoordinator.viewController)
        }
        tabBarController.viewControllers = tabViewControllers
    }
        
    func createTabControllers() {
        tabCoordinators.append(HomeTabCoordinator(tabBarController: tabBarController, title: AppTabs.Home.rawValue, image: UIImage(named: AppTabs.Home.rawValue)))
        
        tabCoordinators.append(FoodSearchCoordinator(tabBarController: tabBarController, title: AppTabs.Search.rawValue, image: UIImage(named: AppTabs.Search.rawValue)))

        tabCoordinators.append(SettingsTabCoordinator(tabBarController: tabBarController, title: AppTabs.Settings.rawValue, image: UIImage(named: AppTabs.Settings.rawValue)))
        
    }

}

