//
//  TimerViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation
import SwiftUI

class TimerViewModel: Clock, ObservableObject {
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var second: Int = 0
    
    func play() {
    }
    
    func pause() {
    }
    
    func stop() {
    }
}
