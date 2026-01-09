//
//  CobOrderDetail+DTO.swift
//  Crumbs
//
//  Created by Christopher Wainwright on 06/09/2025.
//

/// A data transfer object representing the core details of a cob order.
/// 
/// CobOrderDetailDTO encapsulates the selected options that compose a cob:
/// - `filling`: The primary filling chosen for the cob.
/// - `bread`: The type of bread used for the cob.
/// - `sauce`: The sauce accompanying the filling and bread.
/// 
/// This DTO is intended for transporting order detail data between layers (e.g., API boundary,
/// persistence, or UI) without exposing internal domain models. It conforms to `DTO` to indicate
/// its role as a lightweight, serialisable representation.
///
/// Usage:
/// - Construct with explicit `Filling`, `Bread`, and `Sauce` values.
/// - Pass to services or view models that require a stable representation of an order's selections.
///
/// - Note: The types `Filling`, `Bread`, and `Sauce` are expected to be value types
///         (e.g., enums or structs) that unambiguously describe the available options.
///
/// - SeeAlso: `DTO`
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
