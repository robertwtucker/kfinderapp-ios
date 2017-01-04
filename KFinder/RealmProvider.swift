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

struct RealmProvider {
    static var appRealm: Realm = {
        do {
            if let _ = NSClassFromString("XCTest") {
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "KFinder"
                return try Realm()
            } else {
                let config = Realm.Configuration(
                    schemaVersion: 1,
                    migrationBlock: { migration, oldSchemaVersion in
                        // Placeholder for future updates
                        //if oldSchemaVersion < currentSchemaVersion {
                        //  migrate
                        //}
                })
                Realm.Configuration.defaultConfiguration = config
                return try Realm()
            }
        } catch {
            fatalError("Error initializing Realm -> \(error)")
        }
    }()
}
