//
//  File.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

public struct WeekDTO {
    public let week: Int
    public let year: Int
}

public struct WeekOrderDTO {
    public let week: Int
    public let year: Int
    public let orders: [CobOrderDTO]
}
