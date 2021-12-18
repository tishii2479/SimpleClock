//
//  Date.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2021/04/14.
//

import Foundation

extension Date {
    private func formatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = .current
        formatter.timeZone = .current
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
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameMonth(as date: Date) -> Bool {
        isEqual(to: date, toGranularity: .month)
    }
}
