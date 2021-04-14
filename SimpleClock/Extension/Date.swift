//
//  Date.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation

extension Date {
    static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
         
        dateFormatter.dateFormat = "yyyy/mm/dd"
         
        return dateFormatter.string(from: date)
    }
    
    static func formatTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier:  "Asia/Tokyo")
         
        dateFormatter.dateFormat = "HH:mm:ss"
         
        return dateFormatter.string(from: date)
    }
}
