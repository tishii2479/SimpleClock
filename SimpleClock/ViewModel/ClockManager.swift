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
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.currentTime = Date()
        }
    }
}
