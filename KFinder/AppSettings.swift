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
import RxSwift

final class AppSettings {
    
    //MARK: Key Constants
    
    enum Keys: String {
        case baseDataLoaded = "baseDataLoaded"
        case convertFromMetric = "convertFromMetric"
    }
    
    //MARK: Properties
    
    static let sharedState = AppSettings()
    fileprivate let disposeBag = DisposeBag()
    
    private(set) lazy var baseDataLoaded = false
    private(set) lazy var versionNumber = "Unknown"
    private(set) lazy var buildNumber = "Unknown"
    
    
    // Observable
    
    var convertFromMetric = Variable<Bool?>(false)

    //MARK: Initialization
    
    private init() {
        let defaults = UserDefaults.standard
        
        baseDataLoaded = defaults.bool(forKey: Keys.baseDataLoaded.rawValue)
        if let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            self.versionNumber = versionNumber as! String
        }
        if let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") {
            self.buildNumber = buildNumber as! String
        }
        _ = defaults.rx
            .observe(Bool.self, Keys.convertFromMetric.rawValue)
            .debug("AppSettings.\(Keys.convertFromMetric.rawValue).observer")
            .do()
            .bindTo(convertFromMetric)
            .disposed(by: disposeBag)
        
        print("AppSettings.init.convertFromMetric: \(convertFromMetric.value)")
        
}


    //MARK: Support
    
    func versionDescription() -> String {
        return "v\(versionNumber) (\(buildNumber))"
    }
}
