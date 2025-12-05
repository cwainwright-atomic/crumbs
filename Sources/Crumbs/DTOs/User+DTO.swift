//
//  User+DTO.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

public struct UserDTO : DTO {
    public let name: String
    public let email: String
    
    public init(name: String, email: String) {
        self.name = name
        self.email = email.lowercased()
    }
}

public struct TokenDTO : DTO {
    public let value: String
    public let expiry: Date
    
    public init(value: String, expiry: Date) {
        self.value = value
        self.expiry = expiry
    }
}

public struct UserTokenDTO : DTO {
    public let token: TokenDTO
    public let user: UserDTO
    
    public init(value: String, expiry: Date, user: UserDTO) {
        self.token = TokenDTO(value: value, expiry: expiry)
        self.user = user
    }
    
    public init(token: TokenDTO, user: UserDTO) {
        self.token = token
        self.user = user
    }
}
