//
//  Clock.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation

// TODO: Remove, or rename?

protocol Clock {
    // Time in formatted string
    var time: String { get }
    func play()
    func stop()
    func pause()
}
