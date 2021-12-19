//
//  ActivityClockViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

// TODO: Do not use Activity.current

class ActivityClockViewModel: ObservableObject {
    var totalTimeStr: String {
        TimeFormatter.formatTime(second: elapsedTime + totalTime, style: .semi)
    }
    var currentTimeStr: String {
        TimeFormatter.formatTime(second: elapsedTime, style: .semi)
    }
    var monthTimeStr: String {
        TimeFormatter.formatTime(second: elapsedTime + monthTime, style: .semi)
    }
    
    @Published var totalTime: Int = 0
    @Published var monthTime: Int = 0
    @Published var elapsedTime: Int = 0
    private var startDate = Date()
    private var timer = Timer()
    // Cached history is used to restore ActivityHistory before terminate
    // When the app enter background, save new history and hold it at cachedHistory
    // If the app becomes active again, delete the saved cached history
    private var cachedHistory: ActivityHistory? = nil
    
    func onAppear() {
        print("ActivityClockView onAppear")
        startClock()
    }
    
    func onDisappear() {
        print("ActivityClockView onDisappear")
        timer.invalidate()

        cachedHistory = ActivityHistory.create(activity: Activity.current, second: elapsedTime, startDate: startDate, endDate: Date())
    }
    
    func onRestart() {
        print("ActivityClockView onRestart")
        if let history = cachedHistory {
            history.delete()
        }
        cachedHistory = nil
        // TODO: Use same logic at stop watch
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime += 1
        }
    }
    
    private func startClock() {
        totalTime = Activity.current.totalTime
        monthTime = Activity.current.monthTime
        startDate = Date()
        // TODO: Use same logic at stop watch
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime += 1
        }
    }
}
