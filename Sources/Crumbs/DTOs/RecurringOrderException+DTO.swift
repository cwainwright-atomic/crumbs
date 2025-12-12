//
//  RecurringOrderException+DTO.swift
//  crumbs
//
//  Created by Christopher Wainwright on 10/10/2025.
//

import Foundation

public struct RecurringOrderExceptionDTO: DTO {
    public let id: UUID
    public let createdAt: Date
    public let user: UserDTO?
    public let week: WeekDTO?
    
    public init(id: UUID, createdAt: Date, user: UserDTO? = nil, week: WeekDTO? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.user = user
        self.week = week
    }
    
    public func withAssociatedWeek(_ week: WeekDTO) -> WeekOrderVariant {
        .init(id: self.id, exceptionWeek: week)
    }
}
