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
    
    var time: String {
        let minute: Int = elapsedTime / 6000
        let second: Int = elapsedTime / 100 % 60
        let centSecond: Int = elapsedTime % 100
        return String(format: "%02d:%02d:%02d", minute, second, centSecond)
    }
    
    func play() {
        if timer.isValid { return }
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.elapsedTime += 1
        }
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func stop() {
        timer.invalidate()
        elapsedTime = 0
    }
}
