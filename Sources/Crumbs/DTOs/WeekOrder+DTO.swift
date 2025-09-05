//
//  File.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

public struct WeekDTO {
    public let week: Int
    public let year: Int
    
    public init(week: Int, year: Int) {
        self.week = week
        self.year = year
    }
}

public struct WeekOrderDTO {
    public let week: Int
    public let year: Int
    public let orders: [CobOrderDTO]
    
    public init(week: Int, year: Int, orders: [CobOrderDTO]) {
        self.week = week
        self.year = year
        self.orders = orders
    }
}
