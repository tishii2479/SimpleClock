//
//  StopWatch.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2022/01/09.
//

import SwiftUI

protocol TimerDelegate: AnyObject {
    func onTimerUpdate()
}

class StopWatch: ObservableObject {
    enum Status {
        case play
        case pause
        case stop
        case idle
    }

    @Published var elapsedTime: Int = 0
    @Published var status: Status = .idle
    private let interval: Double
    private var timer = Timer()
    // Stores date when the start button is pressed
    private var startDate: Date?
    // Cache elapsed time when used pause
    private var cache: Int = 0
    weak var delegate: TimerDelegate?
    
    init(interval: Double = 0.01) {
        self.interval = interval
    }
    
    func play() {
        guard startDate == nil,
              timer.isValid == false else { return }
        status = .play
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            guard let start = self.startDate else { return }
            let timeInterval = Date().timeIntervalSince(start)
            // Elapsed time is spent time since self.startDate + self.cache
            self.elapsedTime = Int(timeInterval / self.interval) + self.cache
            self.delegate?.onTimerUpdate()
        }
    }
    
    func pause() {
        timer.invalidate()
        startDate = nil
        cache = elapsedTime
        status = .pause
    }
    
    func stop() {
        timer.invalidate()
        elapsedTime = 0
        cache = 0
        startDate = nil
        status = .stop
    }
}
