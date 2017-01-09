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

final class AppSettings {
    
    //MARK: Properties
    
    static let sharedState = AppSettings()
    
    private(set) lazy var baseDataLoaded = false
    private(set) lazy var versionNumber = "Unknown"
    private(set) lazy var buildNumber = "Unknown"
    

    //MARK: Initialization
    
    private init() {
        let defaults = UserDefaults.standard
        
        baseDataLoaded = defaults.bool(forKey: "baseDataLoaded")
        
        if let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            self.versionNumber = versionNumber as! String
        }
        if let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") {
            self.buildNumber = buildNumber as! String
        }
    }


    //MARK: Support
    
    func versionDescription() -> String {
        return "v\(versionNumber) (\(buildNumber))"
    }
}
