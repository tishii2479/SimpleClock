//
//  ActivityHistory.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import Foundation
import RealmSwift

class ActivityHistory: Object {
    @objc dynamic private(set) var activity: Activity?
    @objc dynamic private(set) var startDate = Date()
    @objc dynamic private(set) var endDate = Date()
    
    // (endDate - startDate) in second
    var time: Int {
        return Int(endDate.timeIntervalSince(startDate))
    }
    
    static func create(activity: Activity, startDate: Date, endDate: Date = Date()) {
        let history = ActivityHistory()
        history.startDate = startDate
        history.endDate = endDate
        history.activity = activity

        let realm = try! Realm()
        try! realm.write {
            realm.add(history)
            activity.histories.append(history)
        }
    }
}
