//
//  ActivityClockViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

class ActivityClockViewModel: ObservableObject {
    var totalTimeStr: String {
        TimeFormatter.formatTime(second: Activity.current.totalTime, style: .semi)
    }
    
    private var startDate = Date()
    private var timer = Timer()
    
    func onAppear() {
        print("ActivityClockView onAppear")
        print(Activity.current.histories)
        startClock()
    }
    
    func onDisappear() {
        print("ActivityClockView onDisappear")
        timer.invalidate()

        ActivityHistory.create(activity: Activity.current, startDate: startDate)
    }
    
    private func startClock() {
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            // TODO: Check performance
            // Workaround: Use cache, and update later
            Activity.current.addTime(time: 1)
        }
    }
}
