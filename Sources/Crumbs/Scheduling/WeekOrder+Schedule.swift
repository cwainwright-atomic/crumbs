//
//  WeekOrder+Schedule.swift
//  crumbs
//
//  Created by Christopher Wainwright on 27/09/2025.
//

import Foundation

public extension WeekDTO {
    static func changeoverTime(from date: Date) -> Date? {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = .current
        
        var saturdayComponents = DateComponents()
        saturdayComponents.weekday = 7
        saturdayComponents.hour = 0
        saturdayComponents.minute = 0
        saturdayComponents.second = 0
    
        return calendar.nextDate(after: date, matching: saturdayComponents, matchingPolicy: .nextTime)
    }
    
    static var changeover: Date {
        let currentDate = Date()
        return changeoverTime(from: currentDate) ?? currentDate
    }
    
    static func deadlineTime(from date: Date) -> Date? {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = .current
        
        var thursdayComponents = DateComponents()
        thursdayComponents.weekday = 5
        thursdayComponents.hour = 15
        thursdayComponents.minute = 0
        thursdayComponents.second = 0
        
        return calendar.nextDate(after: date, matching: thursdayComponents, matchingPolicy: .nextTime)
    }
    
    static var deadline: Date {
        let currentDate = Date()
        return deadlineTime(from: currentDate) ?? currentDate
    }
}


public extension WeekDTO {
    func add(weeks: Int) -> WeekDTO? {
        guard let date = self.date,
              let newDate = Calendar.current.date(byAdding: .weekOfYear, value: weeks, to: date)
        else { return nil }
        
        return WeekDTO(from: newDate)
    }
    
    func subtract(weeks: Int) -> WeekDTO? {
        return add(weeks: -weeks)
    }
}
