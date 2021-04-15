//
//  TimerViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation
import SwiftUI

class TimerViewModel: Clock, ObservableObject {
    // Pickerで設定した値の保持
    @Published var selectedHour: Int = 0
    @Published var selectedMinute: Int = 0
    @Published var selectedSecond: Int = 0
    
    var remainingTime: Int = 5 * 60
    var timer = Timer()
    var endDate: Date?
    
    var time: String {
        let hour: Int = remainingTime / 3600
        let minute: Int = remainingTime / 60 % 60
        let second: Int = remainingTime % 60
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
    
    func onChange() {
        setTime()
    }
    
    func play() {
        guard endDate == nil,
              timer.isValid == false else { return }
        endDate = Date().addingTimeInterval(TimeInterval(remainingTime))
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            guard let end = self.endDate else { return }
            let timeInterval = end.timeIntervalSinceNow
            self.remainingTime = Int(timeInterval)
        }
    }
    
    func pause() {
        timer.invalidate()
        endDate = nil
    }
    
    func stop() {
        setTime()
        timer.invalidate()
        endDate = nil
        remainingTime = 0
    }
    
    func setTime() {
        remainingTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
    }
}
