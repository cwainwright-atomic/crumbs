//
//  CobOrder+Content.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

public struct CobOrderDTO : Identifiable, DTO {
    public let id: UUID
    public let createdAt: Date
    public let orderDetail: CobOrderDetailDTO
    public let orderKind: CobOrderKind
    public let user: UserDTO?
    public let week: WeekDTO?
    
    public init(id: UUID, createdAt: Date, orderDetail: CobOrderDetailDTO, orderKind: CobOrderKind, user: UserDTO? = nil, week: WeekDTO? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.orderDetail = orderDetail
        self.orderKind = orderKind
        self.user = user
        self.week = week
    }
}
