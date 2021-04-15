//
//  ClockManager.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation
import AudioToolbox

class ClockManager: ObservableObject {
    // シングルトン
    static let shared = ClockManager()
    
    // 今の時間
    @Published var currentTime: Date = Date()
    
    var timer: Timer = Timer()
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0
    
    // 通知中かどうか
    // タイマーで使用
    @Published var isVibrating: Bool = false

    // 時針の角度
    var hourAngle: Double {
        return Double(hour) * 30.0 + Double(minute) * 0.5
    }
    
    // 分針の角度
    var minuteAngle: Double {
        return Double(minute) * 6.0
    }
    
    init() {
        setTime()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.setTime()
        }
    }
    
    // 時間の設定
    func setTime() {
        self.currentTime = Date()
        self.hour = Calendar.current.component(.hour, from: self.currentTime)
        self.minute = Calendar.current.component(.minute, from: self.currentTime)
        self.second = Calendar.current.component(.second, from: self.currentTime)
    }
    
    // 振動通知（タイマーで利用）
    func vibrate() {
        isVibrating = true
        DispatchQueue.global(qos: .default).async {
            // 10回振動
            for _ in 0 ..< 10 {
                // 途中でstopVibrateが呼ばれていたら終了
                if self.isVibrating == false { break }
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                sleep(1)
            }
            
            DispatchQueue.main.async {
                self.isVibrating = false
            }
        }
    }
    
    // 振動停止
    func stopVibrate() {
        isVibrating = false
    }
}
