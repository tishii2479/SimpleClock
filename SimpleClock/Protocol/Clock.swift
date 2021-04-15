//
//  Clock.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation

protocol Clock {
    // 表示の取得
    var time: String { get }
    // 再生
    func play()
    // 停止（リセット）
    func stop()
    // 停止
    func pause()
}
