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
import RxCocoa
import RealmSwift
import RxRealm

struct SettingsViewModel {

    //MARK: Properties
    
    // Input
    var convertMetricSwitchIsOn = Variable(false)

    // Output
    let navigationBarTitle: Observable<String>
    let applicationVersion: Observable<String>
    let convertFromMetricSetting: Observable<Bool>
    let convertFromMetricTracking: Observable<Void>


    //MARK: Initialization

    init(realm: Realm) {
        navigationBarTitle = .just("Settings")
        applicationVersion = .just("KFinder \(AppSettings.sharedState.versionDescription())")
        
        convertFromMetricSetting = AppSettings.sharedState.convertFromMetric.asObservable()
            .map { guard let convert = $0 else { return false }
                return convert
            }
        
        convertFromMetricTracking = convertMetricSwitchIsOn.asObservable()
            .withLatestFrom(convertFromMetricSetting) { switchIsOn, settingIsOn in
                if switchIsOn != settingIsOn {
                    print("Setting \(AppSettings.Keys.convertFromMetric.rawValue): \(switchIsOn)")
                    UserDefaults.standard.set(switchIsOn, forKey: AppSettings.Keys.convertFromMetric.rawValue)
                }
            }
    }

}
