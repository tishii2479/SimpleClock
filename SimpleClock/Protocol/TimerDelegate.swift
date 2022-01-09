//
//  TimerDelegate.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2022/01/09.
//

import Foundation

protocol TimerDelegate: AnyObject {
    func onTimerUpdate()
}
