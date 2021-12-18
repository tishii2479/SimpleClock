//
//  ActivityViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/18.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var totalTimeStr: String = ""
    @Published var monthTimeStr: String = ""
    var activity: Activity = Activity.current
    
    init() {
        updateActivity()
    }
    
    func updateActivity(activity: Activity = Activity.current) {
        totalTimeStr = TimeFormatter.formatTime(second: activity.totalTime, style: .hms)
        monthTimeStr = TimeFormatter.formatTime(second: activity.monthTime, style: .hms)
    }
}
