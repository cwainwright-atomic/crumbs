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
    public let weekOrder: WeekOrderDTO?
    
    public init(id: UUID, createdAt: Date, orderDetail: CobOrderDetailDTO, orderKind: CobOrderKind, user: UserDTO? = nil, weekOrder: WeekOrderDTO? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.orderDetail = orderDetail
        self.orderKind = orderKind
        self.user = user
        self.weekOrder = weekOrder
    }
}
