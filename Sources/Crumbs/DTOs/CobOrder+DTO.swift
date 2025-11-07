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
    public let user: UserDTO
    public let week: WeekDTO
    
    public init(id: UUID, createdAt: Date, orderDetail: CobOrderDetailDTO, orderKind: CobOrderKind, user: UserDTO, week: WeekDTO) {
        self.id = id
        self.createdAt = createdAt
        self.orderDetail = orderDetail
        self.orderKind = orderKind
        self.user = user
        self.week = week
    }
    
    public struct WeekListItem: Identifiable, DTO {
        public let createdAt: Date
        public let orderDetail: CobOrderDetailDTO
        public let user: UserDTO
        public var id: Int { self.hashValue }
        
        public init(createdAt: Date, orderDetail: CobOrderDetailDTO, user: UserDTO) {
            self.createdAt = createdAt
            self.orderDetail = orderDetail
            self.user = user
        }
        
    }
    
    public struct UserListItem: Identifiable, DTO {
        public let id: UUID
        public let createdAt: Date
        public let orderDetail: CobOrderDetailDTO
        public let week: WeekDTO
        
        public init(id: UUID, createdAt: Date, orderDetail: CobOrderDetailDTO, week: WeekDTO) {
            self.id = id
            self.createdAt = createdAt
            self.orderDetail = orderDetail
            self.week = week
        }
    }
}
