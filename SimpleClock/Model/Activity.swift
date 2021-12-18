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
    @objc dynamic private(set) var title: String
    @objc dynamic private(set) var totalTime: Int = 123456
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
        return Array(realm.objects(Activity.self))
    }
    
    var totalTimeStr: String {
        TimeFormatter.formatTime(second: totalTime, style: .hms)
    }
    
    var monthTimeStr: String {
        TimeFormatter.formatTime(second: 12345, style: .hms)
    }
    
    override init() {
        self.title = "Title"
    }
    
    func addTime(time: Int) {
        try! Realm().write {
            totalTime += time
        }
    }
}
