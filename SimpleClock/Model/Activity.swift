//
//  Activity.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import Foundation
import RealmSwift

class Activity: Object {
    @objc dynamic var title: String
    @objc dynamic var totalTime: Int = 123456
    let histories = List<ActivityHistory>()
    
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
