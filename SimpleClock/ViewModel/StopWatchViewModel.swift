//
//  StopWatchViewModel.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation
import SwiftUI

enum StopWatchStatus {
    // 動いている
    case play
    // 一時停止
    case pause
    // 完了
    case stop
    // なし
    case idle
}

class StopWatchViewModel: Clock, ObservableObject {
    // 経過時間（1/100秒で管理）
    // startDateを元に計算
    @Published var elapsedTime: Int = 0
    // ステータス
    @Published var status: StopWatchStatus = .idle
    var timer = Timer()
    // スタートを押した時間
    var startDate: Date?
    // 途中で一時停止した時に、その時の経過時間を保持
    var cache: Int = 0
    
    // s / 60 * 360
    // 円の角度に利用
    var circleRatio: CGFloat {
        if status == .play || status == .pause {
            return CGFloat(elapsedTime % 6000) / CGFloat(6000)
        } else {
            return 1
        }
    }
    
    // 表示
    var time: String {
        let minute: Int = elapsedTime / 6000
        let second: Int = elapsedTime / 100 % 60
        let centSecond: Int = elapsedTime % 100
        return String(format: "%02d:%02d:%02d", minute, second, centSecond)
    }
    
    // スタート
    func play() {
        guard startDate == nil,
              timer.isValid == false else { return }
        status = .play
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            guard let start = self.startDate else { return }
            let timeInterval = Date().timeIntervalSince(start)
            // 経過時間はstartDateからの経過時間 + cache
            self.elapsedTime = Int(timeInterval * 100) + self.cache
        }
    }
    
    // 一時停止
    func pause() {
        timer.invalidate()
        startDate = nil
        cache = elapsedTime
        status = .pause
    }
    
    // 終了
    func stop() {
        timer.invalidate()
        elapsedTime = 0
        cache = 0
        startDate = nil
        status = .stop
    }
}
