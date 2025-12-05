//
//  CobOrder+DTO.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

public struct CobOrderDTO : Identifiable, DTO {
    public let id: UUID
    public let createdAt: Date
    public let updatedAt: Date
    public let orderDetail: CobOrderDetailDTO
    public let orderKind: CobOrderKind
    
    public init(id: UUID, createdAt: Date, updatedAt: Date, orderDetail: CobOrderDetailDTO, orderKind: CobOrderKind) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.orderDetail = orderDetail
        self.orderKind = orderKind
    
    public struct AssociatedName: Identifiable, DTO {
        public var id: UUID { order.id }
        public var createdAt: Date { order.createdAt }
        public var updatedAt: Date { order.updatedAt }
        public var orderKind: CobOrderKind { order.orderKind }
        public var orderDetail: CobOrderDetailDTO { order.orderDetail }
        
        public let name: String
        public let order: CobOrderDTO
        
        public init(name: String, order: CobOrderDTO) {
            self.name = name
            self.order = order
        }
    }
    
    public struct AssociatedUser: Identifiable, DTO {
        public var id: UUID { order.id }
        public var createdAt: Date { order.createdAt }
        public var updatedAt: Date { order.updatedAt }
        public var orderKind: CobOrderKind { order.orderKind }
        public var orderDetail: CobOrderDetailDTO { order.orderDetail }
        
        public let user: UserDTO
        public let order: CobOrderDTO
        
        public init(user: UserDTO, order: CobOrderDTO) {
            self.user = user
            self.order = order
        }
    }
    
    public func withAssociatedUser(_ user: UserDTO) -> AssociatedUser {
        .init(user: user, order: self)
    }

    public struct AssociatedWeek: Identifiable, DTO {
        
        public var id: Int { self.hashValue }
        
        public let week: WeekDTO
        public let order: CobOrderVariantDTO
        
        public init(week: WeekDTO, order: CobOrderDTO) {
            self.week = week
            self.order = .single(order.orderDetail)
        }
        
        public init(week: WeekDTO, recurringOrder: RecurringOrderDTO) {
            self.week = week
            self.order = .recurring(recurringOrder.orderDetail)
        }
        
        public init(exceptionWeek: WeekDTO) {
            self.week = exceptionWeek
            self.order = .exception
        }
    }
    
    public func withAssociatedWeek(_ week: WeekDTO) -> AssociatedWeek {
        .init(week: week, order: self)
    }
}


public enum CobOrderVariantDTO : DTO { case single(CobOrderDetailDTO), recurring(CobOrderDetailDTO), exception }

extension CobOrderVariantDTO {
    public var orderDetail: CobOrderDetailDTO? {
        switch self {
        case .single(let detail): detail
        case .recurring(let detail): detail
        case .exception: nil
        }
    }
}
