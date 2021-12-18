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
    @objc dynamic private(set) var second: Int = 0
    
    @discardableResult
    static func create(activity: Activity, second: Int, startDate: Date, endDate: Date = Date()) -> ActivityHistory {
        let history = ActivityHistory()
        history.startDate = startDate
        history.endDate = endDate
        history.activity = activity
        history.second = second

        let realm = try! Realm()
        try! realm.write {
            realm.add(history)
            activity.histories.append(history)
        }
        
        return history
    }
    
    func delete() {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {
            print("Realm error, ActivityHistory is deleted already?")
        }
    }
}
