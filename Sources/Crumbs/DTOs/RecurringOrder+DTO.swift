//
//  RecurringOrder+DTO.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

public struct RecurringOrderDTO : DTO {
    public let id: UUID
    public let startWeek: WeekDTO
    public let orderDetail: CobOrderDetailDTO
    
    @available(*, deprecated, renamed: "init(id:startDate:orderDetail:)", message: "This initialiser creates an order with placeholder startWeek and id. This initialiser will be removed in a future release.")
    public init(orderDetail: CobOrderDetailDTO, user: UserDTO? = nil) {
        self.id = UUID()
        self.startWeek = .current
        self.orderDetail = orderDetail
    }
    
    public init(id: UUID, startDate: Date, orderDetail: CobOrderDetailDTO) {
        self.id = id
        self.startWeek = .init(from: startDate)
        self.orderDetail = orderDetail
    }
    
    public struct AssociatedName: Identifiable, DTO {
        public var id: UUID { order.id }
        public var startWeek: WeekDTO { order.startWeek }
        public var orderDetail: CobOrderDetailDTO { order.orderDetail }
        
        public let name: String
        public let order: RecurringOrderDTO
        
        public init(name: String, order: RecurringOrderDTO) {
            self.name = name
            self.order = order
        }
    }
    
    public func withAssociatedName(_ name: String) -> AssociatedName {
        .init(name: name, order: self)
    }
}
