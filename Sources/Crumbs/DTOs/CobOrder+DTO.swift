//
//  CobOrder+Content.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

public struct CobOrderDTO {
    public let id: UUID
    public let createdAt: Date
    public let orderDetail: CobOrderDetailDTO
    public let orderKind: CobOrderKind
    public let user: UserDTO?
    public let weekOrder: WeekOrderDTO?
}
