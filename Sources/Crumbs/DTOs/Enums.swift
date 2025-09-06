//
//  Enums.swift
//  Crumbs
//
//  Created by Christopher Wainwright on 06/09/2025.
//


public enum Filling: String, Codable, Sendable {
    case bacon, sausage, egg, vegan_sausage
}

public enum Bread: String, Codable, Sendable {
    case white, brown
}

public enum Sauce: String, Codable, Sendable {
    case red, brown
}

public enum CobOrderKind : String, Codable, Sendable {
    case single, recurring
}
