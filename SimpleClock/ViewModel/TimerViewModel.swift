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
    
    var time: String {
        let hour: Int = remainingTime / 3600
        let minute: Int = remainingTime / 60 % 60
        let second: Int = remainingTime % 60
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
    
    func onChange() {
        resetTime()
    }
    
    func play() {
        if timer.isValid { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.remainingTime -= 1
        }
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func stop() {
        resetTime()
        timer.invalidate()
    }
    
    func resetTime() {
        remainingTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
    }
}
