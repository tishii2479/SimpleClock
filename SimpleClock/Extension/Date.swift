//
//  Date.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation

extension Date {
    func formatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
        return formatter
    }
    
    func formatDate(format: String = "yyyy/MM/dd") -> String {
        let formatter = formatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    func formatTime(format: String = "HH:mm:ss") -> String {
        let formatter = formatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
