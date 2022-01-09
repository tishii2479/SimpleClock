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
    static var all: Results<Activity> {
        let realm = try! Realm()
        return realm.objects(Activity.self).filter("isDeleted == 0")
    }
    
    // TODO: Check performance
    var totalTime: Int {
        var total: Int = 0
        for history in histories {
            total += history.second
        }
        return total
    }
    
    // TODO: Check performance
    var monthTime: Int {
        var total: Int = 0
        for history in histories {
            if history.startDate.isInSameMonth(as: Date()) {
                total += history.second
            }
        }
        return total
    }
    
    // TODO: Check performance
    var todayTime: Int {
        var total: Int = 0
        for history in histories {
            if history.startDate.isInSameDay(as: Date()) {
                total += history.second
            }
        }
        return total
    }
    
    // TODO: Check performance
    var totalDate: Int {
        var set = Set<Date>()
        for history in histories {
            set.insert(history.startDate.startOfDay)
        }
        return set.count
    }
    
    // TODO: Check performance
    var averageSecondPerDay: Int {
        var dict = [Date : Int]()
        var sum: Int = 0
        for history in histories {
            let day = history.startDate.startOfDay
            if dict[day] == nil {
                dict[day] = 0
            }
            dict[day] = dict[day]! + history.second
            sum += history.second
        }
        return sum / dict.count
    }
    
    // TODO: Check performance
    var consecutiveDayCount: Int {
        var set = Set<Date>()
        for history in histories {
            set.insert(history.startDate.startOfDay)
        }
        var count: Int = 0
        var currentDate: Date = Date()
        while (set.contains(currentDate.startOfDay)) {
            count += 1
            currentDate = currentDate.addingTimeInterval(-24 * 3600)
        }
        return count
    }
    
    var totalTimeStr: String {
        TimeFormatter.formatTime(second: totalTime, style: .hms)
    }
    
    var monthTimeStr: String {
        TimeFormatter.formatTime(second: monthTime, style: .hms)
    }
    
    @discardableResult
    static func create(title: String) -> Activity {
        let activity = Activity()
        activity.title = title
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(activity)
        }
        // Create base history
        ActivityHistory.create(activity: activity, second: 0, startDate: Date(), endDate: Date())
        return activity
    }
    
    func delete() {
        let realm = try! Realm()
        try! realm.write {
            isDeleted = true
        }
    }
    
    func rename(newName: String) {
        let realm = try! Realm()
        try! realm.write {
            title = newName
        }
    }
}
