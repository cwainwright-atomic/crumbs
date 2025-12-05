//
//  CobOrderDetail+DTO.swift
//  Crumbs
//
//  Created by Christopher Wainwright on 06/09/2025.
//

public struct CobOrderDetailDTO : DTO {
    public let filling: Filling
    public let bread: Bread
    public let sauce: Sauce
    
    public init(filling: Filling, bread: Bread, sauce: Sauce) {
        self.filling = filling
        self.bread = bread
        self.sauce = sauce
    }
}
