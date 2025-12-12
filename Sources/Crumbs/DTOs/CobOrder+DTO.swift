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
    public let orderKind: CobOrderKind
    public let orderDetail: CobOrderDetailDTO
    
    public init(id: UUID, createdAt: Date, updatedAt: Date, orderDetail: CobOrderDetailDTO, orderKind: CobOrderKind) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.orderKind = orderKind
        self.orderDetail = orderDetail
    }
    
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
    
    public func withAssociatedName(_ name: String) -> AssociatedName {
        .init(name: name, order: self)
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

    public func withAssociatedWeek(_ week: WeekDTO) -> WeekOrderVariant {
        .init(week: week, order: self)
    }
}

@available(*, deprecated, renamed: "WeekOrderVariant", message: "Due to loose association to CobOrderDTO, AssociatedWeek has been moved and renamed to WeekOrderVariant")
extension CobOrderDTO {
    public typealias AssociatedWeek = WeekOrderVariant
}

public struct WeekOrderVariant: Identifiable, DTO {
    
    public var id: Int { self.hashValue }
    
    public let week: WeekDTO
    public let order: CobOrderVariantDTO
    
    public init(week: WeekDTO, order: CobOrderDTO) {
        self.week = week
        self.order = .single(order.id, order.orderDetail)
    }
    
    public init(week: WeekDTO, recurringOrder: RecurringOrderDTO) {
        self.week = week
        self.order = .recurring(recurringOrder.id, recurringOrder.orderDetail)
    }
    
    @available(*, deprecated, renamed: "init(id:exceptionWeek:)", message: "Please provide a UUID for the exception")
    public init(exceptionWeek: WeekDTO) {
        self.week = exceptionWeek
        self.order = .exception(UUID())
    }
    
    public init(id: UUID, exceptionWeek: WeekDTO) {
        self.week = exceptionWeek
        self.order = .exception(id)
    }
}

public enum CobOrderVariantDTO : DTO { case single(UUID, CobOrderDetailDTO), recurring(UUID, CobOrderDetailDTO), exception(UUID)
    
    @available(*, deprecated, renamed: "single(_:_:)", message: "Please provide a UUID for the order")
    public func single(_ detail: CobOrderDetailDTO) -> Self { .single(UUID(), detail) }
    
    @available(*, deprecated, renamed: "recurring(_:_:)", message: "Please provide a UUID for the order")
    public func recurring(_ detail: CobOrderDetailDTO) -> Self { .recurring(UUID(), detail) }
    
    @available(*, deprecated, renamed: "exception(_:)", message: "Please provide a UUID for the order exception")
    public var exception: Self { .exception(UUID()) }
}

extension CobOrderVariantDTO {
    public var id: UUID {
        switch self {
        case .single(let id, _): id
        case .recurring(let id, _): id
        case .exception(let id): id
        }
    }
    
    public var orderDetail: CobOrderDetailDTO? {
        switch self {
        case .single(_, let detail): detail
        case .recurring(_, let detail): detail
        case .exception: nil
        }
    }
}
