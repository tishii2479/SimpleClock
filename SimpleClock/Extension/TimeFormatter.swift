//
//  TimeFormatter.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/12/15.
//

import Foundation

class TimeFormatter {
    enum FormatStyle: String {
        case hms = "%d h %d m %d s"
        case semi = "%02d:%02d:%02d"
    }
    
    class func formatTime(second: Int, style: FormatStyle) -> String {
        let h: Int = second / 3600
        let m: Int = second / 60 % 60
        let s: Int = second % 60
        return String(format: style.rawValue, h, m, s)
    }
    
    class func formatTime(centSecond: Int, style: FormatStyle) -> String {
        let m: Int = centSecond / 6000
        let s: Int = centSecond / 100 % 60
        let cs: Int = centSecond % 100
        return String(format: style.rawValue, m, s, cs)
    }
}
