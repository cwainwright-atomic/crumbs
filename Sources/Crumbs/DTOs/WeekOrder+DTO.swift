//
//  WeekOrder+DTO.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

public struct WeekDTO : DTO {
    public let week: Int
    public let year: Int
    
    public init(week: Int, year: Int) {
        self.week = week
        self.year = year
    }
    
    public init(from date: Date) {
        let calendar = Calendar(identifier: .iso8601)
        let components = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        self.week = components.weekOfYear!
        self.year = components.yearForWeekOfYear!
    }
    
    public var date: Date? {
        let calendar = Calendar(identifier: .iso8601)
        let dateComponents = DateComponents(weekOfYear: week, yearForWeekOfYear: year)
        return calendar.date(from: dateComponents)
    }
    
    public struct AssociatedOrderDTO: Identifiable, DTO {
        public var id: Int { week.hashValue }
        
        public let week: WeekDTO
        public let order: CobOrderVariantDTO?
        
        public init(week: WeekDTO, order: CobOrderVariantDTO?) {
            self.week = week
            self.order = order
        }
    }

    public func withAssociatedOrder(_ order: CobOrderVariantDTO?) -> AssociatedOrderDTO {
        AssociatedOrderDTO(week: self, order: order )
    }
    
    public struct WeeklyOrderDTO : DTO {
        public let week: WeekDTO
        public let orders: [CobOrderDTO.AssociatedName]
        
        @available(*, deprecated, renamed: "init(week:namedOrders:)", message: "WeeklyOrder now requires an associated username with each CobOrder. For compatibility, this initialiser auto-assigns UUID placeholders and will be removed in a future release.")
        public init(week: WeekDTO, orders: [CobOrderDTO] = []) {
            self.week = week
            self.orders = orders.map { CobOrderDTO.AssociatedName(name: UUID().uuidString, order: $0) }
        }

        public init(week: WeekDTO, namedOrders: [CobOrderDTO.AssociatedName] = []) {
            self.week = week
            self.orders = namedOrders
        }
    }
}

extension WeekDTO : Comparable {
    public static func < (lhs: WeekDTO, rhs: WeekDTO) -> Bool {
        return (lhs.year < rhs.year) || (lhs.year == rhs.year && lhs.week < rhs.week)
    }
}

extension WeekDTO {
    public static var current: WeekDTO {
        let calendar = Calendar(identifier: .iso8601)
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        guard let weekOfYear = components.weekOfYear, let yearForWeekOfYear = components.yearForWeekOfYear
        else { fatalError() }
        return .init(week: weekOfYear, year: yearForWeekOfYear)
    }
}
