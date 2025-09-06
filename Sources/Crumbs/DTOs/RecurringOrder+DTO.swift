//
//  File.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

public struct RecurringOrderDTO : DTO {
    public let orderDetail: CobOrderDetailDTO
    public let user: UserDTO?
    
    public init(orderDetail: CobOrderDetailDTO, user: UserDTO? = nil) {
        self.orderDetail = orderDetail
        self.user = user
    }
}
