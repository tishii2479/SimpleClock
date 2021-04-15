//
//  TimerViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation
import SwiftUI

// タイマーのステータス
enum TimerStatus {
    case play
    case stop
    case pause
    case idle
}

class TimerViewModel: Clock, ObservableObject {
    // Pickerで設定した値の保持
    @Published var selectedHour: Int = 0
    @Published var selectedMinute: Int = 5
    @Published var selectedSecond: Int = 0
    
    // 残り時間
    // endDateから計算
    @Published var remainingTime: Int = 5 * 60
    // 残り時間の割合
    @Published var remainingRatio: CGFloat = 1
    // ステータス
    @Published var status: TimerStatus = .idle
    
    // 設定した時間
    var maxTime: Int = 0
    var timer = Timer()
    // 終了時刻
    var endDate: Date?
    
    // 表示
    var time: String {
        let hour: Int = remainingTime / 3600
        let minute: Int = remainingTime / 60 % 60
        let second: Int = remainingTime % 60
        return String(format: "%02d:%02d:%02d", hour, minute, second)
    }
    
    // ピッカーの値に変化があった時
    func onChange() {
        pause()
        setTime()
    }
    
    // 開始
    func play() {
        guard endDate == nil,
              timer.isValid == false,
              remainingTime > 0 else { return }
        status = .play
        // 終了時刻の設定
        endDate = Date().addingTimeInterval(TimeInterval(remainingTime))
        // 設定時間の保持
        maxTime = remainingTime
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            guard let end = self.endDate else { return }
            let timeInterval = end.timeIntervalSinceNow
            self.remainingTime = Int(timeInterval)
            self.remainingRatio = CGFloat(self.remainingTime) / CGFloat(self.maxTime)
            // 残りが0秒未満になったら終了
            if timeInterval <= 0.0 {
                self.finish()
            }
        }
    }
    
    // 終了
    func finish() {
        stop()
        // 振動通知を呼ぶ
        ClockManager.shared.vibrate()
    }
    
    // 一時停止
    func pause() {
        if timer.isValid { timer.invalidate() }
        endDate = nil
        status = .pause
    }
    
    // 終了
    func stop() {
        if timer.isValid { timer.invalidate() }
        endDate = nil
        status = .pause
        setTime()
    }
    
    // 時間の設定
    func setTime() {
        remainingTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
    }
}
