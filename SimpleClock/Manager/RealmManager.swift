//
//  RealmManager.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2022/01/09.
//

import RealmSwift

class RealmManager {
    static func start() {
#if DEBUG
//        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
//            try! FileManager.default.removeItem(at: fileURL)
//        }
        print("Realm file path: ", Realm.Configuration.defaultConfiguration.fileURL!)
#endif
        // TODO: Create AppDelegate/SceneDelegate and move
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 3,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 3) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            }
        )

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
}
