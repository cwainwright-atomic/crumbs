//
//  File.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

public struct WeekDTO : DTO {
    public let week: Int
    public let year: Int
    
    public init(week: Int, year: Int) {
        self.week = week
        self.year = year
    }
}

extension WeekDTO : Comparable {
    public static func < (lhs: WeekDTO, rhs: WeekDTO) -> Bool {
        return (lhs.year < rhs.year) || (lhs.year == rhs.year && lhs.week < rhs.week)
    }
}

public struct WeekOrderDTO : DTO {
    public let week: Int
    public let year: Int
    public let orders: [CobOrderDTO]
    
    public init(week: Int, year: Int, orders: [CobOrderDTO] = []) {
        self.week = week
        self.year = year
        self.orders = orders
    }
}
