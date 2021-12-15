//
//  ActivityHistory.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import Foundation
import RealmSwift

class ActivityHistory: Object {
    @objc dynamic var startDate = Date()
    @objc dynamic var endDate = Date()
    
    // (endDate - startDate) in second
    var time: Int {
        return Int(endDate.timeIntervalSince(startDate))
    }
}
