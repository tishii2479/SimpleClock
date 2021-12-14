//
//  ClockManager.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation
import AudioToolbox

class ClockManager: ObservableObject {
    static let shared = ClockManager()
    
    @Published var currentTime: Date = Date()
    
    private var timer: Timer = Timer()
    private var hour: Int = 0
    private var minute: Int = 0
    private var second: Int = 0
    
    @Published var isVibrating: Bool = false

    var hourAngle: Double {
        return Double(hour) * 30.0 + Double(minute) * 0.5
    }
    
    var minuteAngle: Double {
        return Double(minute) * 6.0
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
    
    func vibrate() {
        isVibrating = true
        DispatchQueue.global(qos: .default).async {
            for _ in 0 ..< 10 {
                // if stopVibrate() is called, stop vibrating
                if self.isVibrating == false { break }
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                sleep(1)
            }
            
            DispatchQueue.main.async {
                self.isVibrating = false
            }
        }
    }
    
    func stopVibrate() {
        isVibrating = false
    }
}
