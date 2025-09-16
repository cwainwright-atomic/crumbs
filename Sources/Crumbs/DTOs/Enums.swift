//
//  Enums.swift
//  Crumbs
//
//  Created by Christopher Wainwright on 06/09/2025.
//


public protocol DTOEnum: DTO, CaseIterable {}

public enum Filling: String, DTOEnum {
    case bacon, sausage, egg, vegan_sausage
}

public enum Bread: String, DTOEnum {
    case white, brown
}

public enum Sauce: String, DTOEnum {
    case red, brown
}

public enum CobOrderKind : String, DTOEnum {
    case single, recurring
}
