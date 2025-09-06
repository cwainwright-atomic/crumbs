//
//  Enums.swift
//  Crumbs
//
//  Created by Christopher Wainwright on 06/09/2025.
//


public enum Filling: String, DTO {
    case bacon, sausage, egg, vegan_sausage
}

public enum Bread: String, DTO {
    case white, brown
}

public enum Sauce: String, DTO {
    case red, brown
}

public enum CobOrderKind : String, DTO {
    case single, recurring
}
