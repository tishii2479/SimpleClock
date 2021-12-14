//
//  Activity.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import Foundation

class Activity {
    var title: String
    var id: Int
    var totalTime: Int {
        return 0
    }
    
    init(id: Int) {
        self.id = id
        self.title = "Title"
    }
}
