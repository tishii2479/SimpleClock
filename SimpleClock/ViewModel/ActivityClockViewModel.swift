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
    var todayTimeStr: String {
        TimeFormatter.formatTime(second: elapsedTime + todayTime, style: .semi)
    }
    
    @Published var totalTime: Int = 0
    @Published var monthTime: Int = 0
    @Published var todayTime: Int = 0
    @Published var elapsedTime: Int = 0
    @Published var isBright: Bool = true
    private let currentBrightness: CGFloat = UIScreen.main.brightness
    private var startDate = Date()
    private var timer = Timer()
    // Cached history is used to restore ActivityHistory before terminate
    // When the app enter background, save new history and hold it at cachedHistory
    // If the app becomes active again, delete the saved cached history
    private var cachedHistory: ActivityHistory? = nil
    
    func onAppear() {
        print("ActivityClockView onAppear")
        startClock()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func onDisappear() {
        print("ActivityClockView onDisappear")
        timer.invalidate()

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
        if timer.isValid { timer.invalidate() }
        // TODO: Use same logic at stop watch
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime += 1
        }
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func toggleBrightness() {
        isBright.toggle()
        UIScreen.main.brightness = isBright ? currentBrightness : 0.1
        print(UIScreen.main.brightness)
    }
    
    private func startClock() {
        totalTime = Activity.current.totalTime
        monthTime = Activity.current.monthTime
        todayTime = Activity.current.todayTime
        startDate = Date()
        // TODO: Use same logic at stop watch
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime += 1
        }
    }
}
