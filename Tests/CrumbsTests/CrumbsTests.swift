import Foundation
import Testing
@testable import Crumbs

@Suite
struct ChangeoverTime {
    @Test
    func testBeforeChangeoverTime() {
        let calendar = Calendar(identifier: .iso8601)
        let components = DateComponents(year: 2025, month: 11, day: 07)
        let date = calendar.date(from: components)!
        
        let changeoverTime = WeekDTO.changeoverTime(from: date)!
        
        let changeoverComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: changeoverTime)
        
        #expect(changeoverComponents.year == 2025)
        #expect(changeoverComponents.month == 11)
        #expect(changeoverComponents.day == 08)
        #expect(changeoverComponents.hour == 0)
        #expect(changeoverComponents.minute == 0)
    }
    
    @Test
    func testAtChangeoverTime() {
        let components = DateComponents(year: 2025, month: 11, day: 08)
        let date = Calendar.current.date(from: components)!
        
        let changeoverTime = WeekDTO.changeoverTime(from: date)!
        
        let changeoverComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: changeoverTime)
        
        #expect(changeoverComponents.year == 2025)
        #expect(changeoverComponents.month == 11)
        #expect(changeoverComponents.day == 15)
        #expect(changeoverComponents.hour == 0)
        #expect(changeoverComponents.minute == 0)
    }
    
    @Test
    func testafterChangeoverTime() {
        let components = DateComponents(year: 2025, month: 11, day: 09)
        let date = Calendar.current.date(from: components)!
        
        let changeoverTime = WeekDTO.changeoverTime(from: date)!
        
        let changeoverComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: changeoverTime)
        
        #expect(changeoverComponents.year == 2025)
        #expect(changeoverComponents.month == 11)
        #expect(changeoverComponents.day == 15)
        #expect(changeoverComponents.hour == 0)
        #expect(changeoverComponents.minute == 0)
    }
}

@Suite
struct DeadlineTime {
    @Test
    func testBeforeDeadline() {
        let calendar = Calendar(identifier: .iso8601)
        let components = DateComponents(year: 2025, month: 11, day: 06)
        let date = calendar.date(from: components)!
        
        let deadlineTime = WeekDTO.deadlineTime(from: date)!
        
        let deadlineComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: deadlineTime)
        
        #expect(deadlineComponents.year == 2025)
        #expect(deadlineComponents.month == 11)
        #expect(deadlineComponents.day == 06)
        #expect(deadlineComponents.hour == 15)
        #expect(deadlineComponents.minute == 00)
    }
    
    @Test
    func testAtDeadline() {
        let calendar = Calendar(identifier: .iso8601)
        let components = DateComponents(year: 2025, month: 11, day: 06, hour: 15, minute: 00)
        let date = calendar.date(from: components)!
        
        let deadlineTime = WeekDTO.deadlineTime(from: date)!
        
        let deadlineComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: deadlineTime)
        
        #expect(deadlineComponents.year == 2025)
        #expect(deadlineComponents.month == 11)
        #expect(deadlineComponents.day == 13)
        #expect(deadlineComponents.hour == 15)
        #expect(deadlineComponents.minute == 00)
    }
    
    @Test
    func testAfterDeadline() {
        let calendar = Calendar(identifier: .iso8601)
        let components = DateComponents(year: 2025, month: 11, day: 07)
        let date = calendar.date(from: components)!
        
        let deadlineTime = WeekDTO.deadlineTime(from: date)!
        
        let deadlineComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: deadlineTime)
        
        #expect(deadlineComponents.year == 2025)
        #expect(deadlineComponents.month == 11)
        #expect(deadlineComponents.day == 13)
        #expect(deadlineComponents.hour == 15)
        #expect(deadlineComponents.minute == 00)
    }
}
