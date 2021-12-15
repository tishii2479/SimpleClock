//
//  ActivityManager.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/15.
//

import SwiftUI
import RealmSwift

class ActivityManager: ObservableObject {
    static let shared = ActivityManager()
    
    var activities: [Activity]
    @Published var currentActivity: Activity
    
    init() {
        let realm = try! Realm()
        activities = Array(realm.objects(Activity.self))
        currentActivity = activities[0]
    }
}
