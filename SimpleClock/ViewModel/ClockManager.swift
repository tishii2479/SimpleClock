//
//  ClockManager.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//


import Foundation

class ClockManager: ObservableObject {
    @Published var currentTime: Date = Date()
    var timer: Timer = Timer()
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0

    var hourAngle: Double {
        return Double(hour) * 30.0 + Double(minute) * 0.5
    }
    
    init() {
        setTime()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.setTime()
        }
    }
    
    func setTime() {
        self.currentTime = Date()
        self.hour = Calendar.current.component(.hour, from: self.currentTime)
        self.minute = Calendar.current.component(.minute, from: self.currentTime)
        self.second = Calendar.current.component(.second, from: self.currentTime)
    }
}
