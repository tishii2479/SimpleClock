//
//  ActivityClockViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

class ActivityClockViewModel: ObservableObject {
    var totalTimeStr: String {
        TimeFormatter.formatTime(second: elapsedTime + totalTime, style: .semi)
    }
    
    private var totalTime: Int = 0
    @Published var elapsedTime: Int = 0
    private var startDate = Date()
    private var timer = Timer()
    
    func onAppear() {
        print("ActivityClockView onAppear")
        startClock()
    }
    
    func onDisappear() {
        print("ActivityClockView onDisappear")
        timer.invalidate()

        ActivityHistory.create(activity: Activity.current, second: elapsedTime, startDate: startDate)
    }
    
    private func startClock() {
        totalTime = Activity.current.totalTime
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime += 1
        }
    }
}
