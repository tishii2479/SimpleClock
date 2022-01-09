//
//  TimerViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    enum TimerStatus {
        case play
        case stop
        case pause
        case idle
    }

    @Published var selectedHour: Int = 0
    @Published var selectedMinute: Int = 5
    @Published var selectedSecond: Int = 0
    
    @Published var remainingTime: Int = 5 * 60
    @Published var status: TimerStatus = .idle
    
    // Setted time
    private var maxTime: Int = 0
    private var timer = Timer()
    private var endDate: Date?
    
    var remainingRatio: CGFloat {
        if status == .play || status == .pause {
            return CGFloat(self.remainingTime) / CGFloat(self.maxTime)
        } else {
            return 1
        }
    }
    
    var time: String {
        TimeFormatter.formatTime(second: remainingTime, style: .semi)
    }
    
    func onPickerChange() {
        pause()
        setTime()
    }
    
    func play() {
        guard endDate == nil,
              timer.isValid == false,
              remainingTime > 0 else { return }
        if status != .pause {
            setTime()
        }
        status = .play
        endDate = Date().addingTimeInterval(TimeInterval(remainingTime))
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            guard let end = self.endDate else { return }
            let timeInterval = end.timeIntervalSinceNow
            self.remainingTime = Int(timeInterval)
            // End when time interval is below 0.0
            if timeInterval <= 0.0 {
                self.finish()
            }
        }
    }
    
    func finish() {
        stop()
        NotificationManager.shared.vibrate()
    }
    
    func pause() {
        if timer.isValid { timer.invalidate() }
        endDate = nil
        status = .pause
    }
    
    func stop() {
        if timer.isValid { timer.invalidate() }
        endDate = nil
        status = .stop
        setTime()
    }

    func setTime() {
        remainingTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
        maxTime = remainingTime
    }
}
