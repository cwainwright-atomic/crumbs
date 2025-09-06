//
//  User.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

public struct UserDTO {
    public let name: String
    public let email: String
    
    public init(name: String, email: String) {
        self.name = name
        self.email = email.lowercased()
    }
}

extension UserDTO : Codable, Sendable {}


public struct UserTokenDTO {
    public let id: UUID
    public let value: String
    public let expiry: Date
    public let user: UserDTO
    
    public init(id: UUID, value: String, expiry: Date, user: UserDTO) {
        self.id = id
        self.value = value
        self.expiry = expiry
        self.user = user
    }
}

extension UserTokenDTO : Codable, Sendable {}
