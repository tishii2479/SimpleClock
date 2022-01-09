//
//  Clock.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation

class Clock: ObservableObject {
    @Published var currentTime: Date = Date()
    private var timer: Timer = Timer()
    private var hour: Int {
        Calendar.current.component(.hour, from: currentTime)
    }
    private var minute: Int {
        Calendar.current.component(.minute, from: currentTime)
    }
    private var second: Int {
        Calendar.current.component(.second, from: currentTime)
    }
    var hourAngle: Double {
        Double(hour) * 30.0 + Double(minute) * 0.5
    }
    var minuteAngle: Double {
        Double(minute) * 6.0
    }
    
    init() {
        setTime()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.setTime()
        }
    }
    
    func setTime() {
        currentTime = Date()
    }
}
