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
    var currentTimeStr: String {
        TimeFormatter.formatTime(second: elapsedTime, style: .semi)
    }
    var monthTimeStr: String {
        TimeFormatter.formatTime(second: elapsedTime + monthTime, style: .semi)
    }
    var todayTimeStr: String {
        TimeFormatter.formatTime(second: elapsedTime + todayTime, style: .semi)
    }
    
    private let currentBrightness: CGFloat = UIScreen.main.brightness
    private let startDate = Date()
    
    @Published var totalTime: Int = 0
    @Published var monthTime: Int = 0
    @Published var todayTime: Int = 0
    @Published var elapsedTime: Int = 0
    @Published var isBright: Bool = true
    // Cached history is used to restore ActivityHistory before terminate
    // When the app enter background, save new history and hold it at cachedHistory
    // If the app becomes active again, delete the saved cached history
    private var cachedHistory: ActivityHistory? = nil
    private var stopWatch = StopWatch(interval: 1)
    
    func onAppear() {
        print("ActivityClockView onAppear")
        startClock()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func onDisappear() {
        print("ActivityClockView onDisappear")
        stopWatch.pause()

        cachedHistory = ActivityHistory.create(activity: Activity.current, second: elapsedTime, startDate: startDate, endDate: Date())

        if !isBright { toggleBrightness() }
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func onRestart() {
        print("ActivityClockView onRestart")
        if let history = cachedHistory {
            history.delete()
        }
        cachedHistory = nil

        stopWatch.play()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func toggleBrightness() {
        isBright.toggle()
        UIScreen.main.brightness = isBright ? currentBrightness : 0.1
    }
    
    private func startClock() {
        totalTime = Activity.current.totalTime
        monthTime = Activity.current.monthTime
        todayTime = Activity.current.todayTime
        
        stopWatch.delegate = self
        stopWatch.play()
    }
}

extension ActivityClockViewModel: TimerDelegate {
    func onTimerUpdate() {
        elapsedTime = stopWatch.elapsedTime
    }
}
