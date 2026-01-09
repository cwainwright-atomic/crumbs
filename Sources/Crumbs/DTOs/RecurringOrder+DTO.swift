//
//  RecurringOrder+DTO.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

/// A data transfer object representing a recurring order.
/// 
/// RecurringOrderDTO encapsulates the minimal information needed to describe
/// an order that repeats on a weekly cadence. It includes a stable identifier,
/// the starting week for the recurrence, and the detailed order payload.
/// 
/// Key points:
/// - `id`: A unique, stable identifier for the recurring order.
/// - `startWeek`: The week (year/week-of-year) the recurring order begins.
/// - `orderDetail`: The full details of what is being ordered (quantities, items, etc.).
/// 
/// Initialisers:
/// - Deprecated: `init(orderDetail:user:)` creates a placeholder order with a new UUID
///   and the current week as the start week. Prefer the designated initialiser below.
/// - Designated: `init(id:startDate:orderDetail:)` constructs a recurring order by
///   converting the given start date into a `WeekDTO`.
/// 
/// Nested types:
/// - `AssociatedName`: A lightweight wrapper that associates a human-readable name
///   with a `RecurringOrderDTO` while preserving the same identity (`id`) and schedule
///   (`startWeek`). Useful for UI presentation and selection lists.
/// 
/// Convenience methods:
/// - `withAssociatedName(_:)`: Returns an `AssociatedName` wrapper that pairs the
///   current recurring order with a display name.
/// - `withAssociatedWeek(_:)`: Returns a `WeekOrderVariant` that binds the current
///   recurring order to a specific `WeekDTO`, enabling per-week views or overrides.
/// 
/// Usage:
/// - Construct with `init(id:startDate:orderDetail:)`.
/// - Present in UI by calling `withAssociatedName(_:)`.
/// - Derive a week-specific variant via `withAssociatedWeek(_:)`.
/// 
/// Thread-safety:
/// - This DTO is an immutable value type and is safe to pass across threads.
/// 
/// Deprecations:
/// - The `init(orderDetail:user:)` initialiser is deprecated and will be removed in a future release.
///   Migrate to `init(id:startDate:orderDetail:)`.
/// 
/// See also:
/// - `WeekDTO` for week-based scheduling semantics.
/// - `CobOrderDetailDTO` for the order payload structure.
/// - `WeekOrderVariant` for week-specific variants of a recurring order.
public struct RecurringOrderDTO : DTO {
    public let id: UUID
    public let startWeek: WeekDTO
    public let orderDetail: CobOrderDetailDTO
    
    @available(*, deprecated, renamed: "init(id:startDate:orderDetail:)", message: "This initialiser creates an order with placeholder startWeek and id. This initialiser will be removed in a future release.")
    public init(orderDetail: CobOrderDetailDTO, user: UserDTO? = nil) {
        self.id = UUID()
        self.startWeek = .current
        self.orderDetail = orderDetail
    }
    
    public init(id: UUID, startDate: Date, orderDetail: CobOrderDetailDTO) {
        self.id = id
        self.startWeek = .init(from: startDate)
        self.orderDetail = orderDetail
    }
    
    /// A lightweight wrapper that associates a human‑readable name with a `RecurringOrderDTO`.
    ///
    /// AssociatedName preserves the identity and schedule of the underlying recurring order
    /// while providing a display-ready `name`. This is useful for UI lists, pickers, and
    /// anywhere a user-friendly label should accompany a recurring order.
    ///
    /// Identity:
    /// - `id`: Proxies the `UUID` of the wrapped `RecurringOrderDTO`, ensuring stable identity.
    ///
    /// Forwarded properties (read-only):
    /// - `startWeek`: The starting `WeekDTO` of the recurring order.
    /// - `orderDetail`: The `CobOrderDetailDTO` payload of the recurring order.
    ///
    /// Stored properties:
    /// - `name`: A human-readable label for presenting the recurring order.
    /// - `order`: The underlying `RecurringOrderDTO` being named.
    ///
    /// Initialisation:
    /// - `init(name:order:)`: Creates a named wrapper around the provided recurring order.
    ///
    /// Typical usage:
    /// - Present recurring orders in UI with user-friendly labels while retaining stable identity:
    ///   - Display `name` for the user.
    ///   - Use `id` for diffing/selection.
    ///   - Access `startWeek` and `orderDetail` as needed for context.
    ///
    /// Thread-safety:
    /// - Value type with immutable stored properties; safe to pass across threads.
    ///
    /// Conformance:
    /// - `Identifiable`: Identity is derived from the wrapped order’s `id`.
    /// - `DTO`: Suitable for transfer across layers and persistence boundaries.
    public struct AssociatedName: Identifiable, DTO {
        public var id: UUID { order.id }
        public var startWeek: WeekDTO { order.startWeek }
        public var orderDetail: CobOrderDetailDTO { order.orderDetail }
        
        public let name: String
        public let order: RecurringOrderDTO
        
        public init(name: String, order: RecurringOrderDTO) {
            self.name = name
            self.order = order
        }
    }
    
    public func withAssociatedName(_ name: String) -> AssociatedName {
        .init(name: name, order: self)
    }
    
    public func withAssociatedWeek(_ week: WeekDTO) -> WeekOrderVariant {
        .init(week: week, recurringOrder: self)
    }
}
