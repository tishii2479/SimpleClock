//
//  StopWatchViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation
import SwiftUI

class StopWatchViewModel: Clock, ObservableObject {
    @Published var elapsedTime: Int = 0
    var timer = Timer()
    var startDate: Date?
    var cache: Int = 0
    
    var time: String {
        let minute: Int = elapsedTime / 6000
        let second: Int = elapsedTime / 100 % 60
        let centSecond: Int = elapsedTime % 100
        return String(format: "%02d:%02d:%02d", minute, second, centSecond)
    }
    
    func play() {
        guard startDate == nil,
              timer.isValid == false else { return }
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            guard let start = self.startDate else { return }
            let timeInterval = Date().timeIntervalSince(start)
            self.elapsedTime = Int(timeInterval * 100) + self.cache
        }
    }
    
    func pause() {
        timer.invalidate()
        startDate = nil
        cache = elapsedTime
    }
    
    func stop() {
        timer.invalidate()
        elapsedTime = 0
        cache = 0
        startDate = nil
    }
}
