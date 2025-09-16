//
//  Enums.swift
//  Crumbs
//
//  Created by Christopher Wainwright on 06/09/2025.
//

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol DTOEnum: DTO, Identifiable, CaseIterable {}

public enum Filling: String, DTOEnum {
    case bacon, sausage, egg, vegan_sausage
    
    public var id : Self { self }
}

public enum Bread: String, DTOEnum {
    case white, brown
    
    public var id : Self { self }
}

public enum Sauce: String, DTOEnum {
    case red, brown
    
    public var id : Self { self }
}

public enum CobOrderKind : String, DTOEnum {
    case single, recurring
    
    public var id : Self { self }
}
