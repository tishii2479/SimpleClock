//
//  Activity.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI
import RealmSwift
import Foundation

class Activity: Object {
    @objc dynamic private(set) var title: String = ""
    @objc dynamic private(set) var isDeleted: Bool = false
    let histories = RealmSwift.List<ActivityHistory>()
    
    private static var _current: Activity?
    static var current: Activity {
        get {
            // TODO: Send error if nil
            _current ?? all[0]
        }
        set { _current = newValue }
    }
    static var all: [Activity] {
        let realm = try! Realm()
        return Array(realm.objects(Activity.self).filter("isDeleted == 0"))
    }
    
    // TODO: Check performance for totalTime and monthTime and improve
    var totalTime: Int {
        var total: Int = 0
        for history in histories {
            total += history.time
        }
        return total
    }

    var monthTime: Int {
        var total: Int = 0
        for history in histories {
            if history.startDate.isInSameMonth(as: Date()) {
                total += history.time
            }
        }
        return total
    }
    
    var totalTimeStr: String {
        TimeFormatter.formatTime(second: totalTime, style: .hms)
    }
    
    var monthTimeStr: String {
        TimeFormatter.formatTime(second: monthTime, style: .hms)
    }
    
    static func create(title: String) {
        let activity = Activity()
        activity.title = title
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(activity)
        }
    }
    
    func delete() {
        let realm = try! Realm()
        try! realm.write {
            isDeleted = true
        }
    }
}
