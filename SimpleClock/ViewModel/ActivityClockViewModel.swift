//
//  ActivityClockViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/14.
//

import SwiftUI

class ActivityClockViewModel: ObservableObject {
    var totalTimeStr: String {
        TimeFormatter.formatTime(second: activity.totalTime + elapsedTime, style: .semi)
    }
    
    @Published var elapsedTime: Int = 0
    private let activity: Activity = ActivityManager.shared.currentActivity
    private var timer = Timer()
    
    func onAppear() {
        print("ActivityClockView onAppear")
        startClock()
    }
    
    func onDisappear() {
        print("ActivityClockView onDisappear")
        activity.addTime(time: elapsedTime)
    }
    
    private func startClock() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime += 1
        }
    }
}
