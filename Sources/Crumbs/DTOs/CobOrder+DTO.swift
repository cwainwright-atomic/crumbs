//
//  CobOrder+DTO.swift
//  CobWeb
//
//  Created by Christopher Wainwright on 31/08/2025.
//

import Foundation

/// A data transfer object representing a single concrete order.
///
/// CobOrderDTO encapsulates the core attributes of an order as it is moved across
/// layers (e.g., networking, persistence, or view models). It conforms to both
/// Identifiable and DTO to integrate smoothly with SwiftUI lists and the app’s
/// DTO layer.
///
/// Key characteristics:
/// - Each order has a stable UUID `id`.
/// - Timestamps track creation (`createdAt`) and last update (`updatedAt`).
/// - `orderDetail` holds the full, structured description of the order contents.
///
/// Associated wrappers:
/// - `AssociatedName`: Pairs an order with an arbitrary displayable name while
///   forwarding identity and timestamps from the underlying order.
/// - `AssociatedUser`: Pairs an order with a specific `UserDTO`, similarly
///   forwarding identity and timestamps.
/// - `withAssociatedName(_:)` and `withAssociatedUser(_:)` are convenience
///   factories for those wrappers.
///
/// Week association:
/// - `withAssociatedWeek(_:)` produces a `WeekOrderVariant`, a lightweight
///   pairing between an order (or other order variants) and a specific `WeekDTO`.
///   This enables scheduling and calendar-like displays without changing the
///   base order data.
///
/// Notes:
/// - Prefer using the provided association helpers to keep identity and
///   timestamps consistent across composed types.
/// - See `WeekOrderVariant` and `CobOrderVariantDTO` for representing orders as
///   single, recurring, or exception variants bound to a calendar week.
///
/// Thread-safety: As an immutable struct with value semantics, CobOrderDTO is
/// safe to pass across threads. Mutations require constructing a new instance.
///
/// Use cases:
/// - Transporting order data between API and UI layers.
/// - Displaying orders in SwiftUI lists by `id`.
/// - Composing orders with user or week context without duplicating data.
public struct CobOrderDTO : Identifiable, DTO {
    public let id: UUID
    public let createdAt: Date
    public let updatedAt: Date
    public let orderDetail: CobOrderDetailDTO
    
    public init(id: UUID, createdAt: Date, updatedAt: Date, orderDetail: CobOrderDetailDTO) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.orderDetail = orderDetail
    }
    
    /// A lightweight wrapper that associates a displayable name with a concrete `CobOrderDTO`.
    ///
    /// AssociatedName forwards identity (`id`) and timestamps (`createdAt`, `updatedAt`) from the
    /// underlying `order`, while adding a `name` used for presentation (e.g., labeling an order in
    /// lists or search results).
    ///
    /// Key points:
    /// - `id`, `createdAt`, `updatedAt`, and `orderDetail` are derived directly from the wrapped `order`.
    /// - `name` provides a human-friendly label without altering the base order data.
    /// - Conforms to `Identifiable` and `DTO` for seamless integration with SwiftUI and the app’s DTO layer.
    ///
    /// Typical usage:
    /// - Display an order with a user-entered or contextual name in UI lists.
    /// - Pass around a named order without duplicating or mutating the original `CobOrderDTO`.
    ///
    /// Creation:
    /// - Prefer `CobOrderDTO.withAssociatedName(_:)` to build this wrapper while preserving identity.
    /// - You can also initialize directly with `init(name:order:)` if needed.
    ///
    /// Thread-safety:
    /// - Immutable value type; safe to pass across threads.
    ///
    /// See also:
    /// - `CobOrderDTO.withAssociatedName(_:)`
    /// - `CobOrderDTO.AssociatedUser` for pairing with a `UserDTO`
    /// - `WeekOrderVariant` for associating orders with a specific week.
    public struct AssociatedName: Identifiable, DTO {
        public var id: UUID { order.id }
        public var createdAt: Date { order.createdAt }
        public var updatedAt: Date { order.updatedAt }
        public var orderDetail: CobOrderDetailDTO { order.orderDetail }
        
        public let name: String
        public let order: CobOrderDTO
        
        public init(name: String, order: CobOrderDTO) {
            self.name = name
            self.order = order
        }
    }
    
    public func withAssociatedName(_ name: String) -> AssociatedName {
        .init(name: name, order: self)
    }
    
    /// A lightweight wrapper that pairs a concrete `CobOrderDTO` with a specific `UserDTO`.
    ///
    /// AssociatedUser forwards identity (`id`) and timestamps (`createdAt`, `updatedAt`) from the
    /// underlying `order`, while attaching a `user` for contextual usage (e.g., ownership, assignment,
    /// filtering, or display in user-centric views).
    ///
    /// Key points:
    /// - `id`, `createdAt`, `updatedAt`, and `orderDetail` are derived directly from the wrapped `order`.
    /// - `user` provides the associated user context without altering the base order data.
    /// - Conforms to `Identifiable` and `DTO` for seamless integration with SwiftUI and the app’s DTO layer.
    ///
    /// Typical usage:
    /// - Display an order within a user’s profile or task list.
    /// - Filter or group orders by user in UI lists or analytics.
    /// - Pass around a user-associated order without duplicating or mutating the original `CobOrderDTO`.
    ///
    /// Creation:
    /// - Prefer `CobOrderDTO.withAssociatedUser(_:)` to build this wrapper while preserving identity.
    /// - You can also initialize directly with `init(user:order:)` if needed.
    ///
    /// Thread-safety:
    /// - Immutable value type; safe to pass across threads.
    ///
    /// See also:
    /// - `CobOrderDTO.withAssociatedUser(_:)`
    /// - `CobOrderDTO.AssociatedName` for pairing with a displayable name
    /// - `WeekOrderVariant` for associating orders with a specific week.
    public struct AssociatedUser: Identifiable, DTO {
        public var id: UUID { order.id }
        public var createdAt: Date { order.createdAt }
        public var updatedAt: Date { order.updatedAt }
        public var orderDetail: CobOrderDetailDTO { order.orderDetail }
        
        public let user: UserDTO
        public let order: CobOrderDTO
        
        public init(user: UserDTO, order: CobOrderDTO) {
            self.user = user
            self.order = order
        }
    }
    
    public func withAssociatedUser(_ user: UserDTO) -> AssociatedUser {
        .init(user: user, order: self)
    }

    public func withAssociatedWeek(_ week: WeekDTO) -> WeekOrderVariant {
        .init(week: week, order: self)
    }
}

@available(*, deprecated, renamed: "WeekOrderVariant", message: "Due to loose association to CobOrderDTO, AssociatedWeek has been moved and renamed to WeekOrderVariant")
extension CobOrderDTO {
    public typealias AssociatedWeek = WeekOrderVariant
}

/// A lightweight pairing between an order variant and a specific calendar week.
///
/// WeekOrderVariant lets you associate either:
/// - a concrete single order (CobOrderDTO),
/// - a recurring order (RecurringOrderDTO), or
/// - an explicit exception (a week with no order),
/// with a particular WeekDTO for scheduling, calendar, and planning views.
///
/// Identity:
/// - The `id` is derived from the instance’s hash value to provide a stable, list-friendly identifier
///   for UI use. It intentionally reflects both the `week` and the underlying `order` variant.
///
/// Composition:
/// - `week`: The WeekDTO this variant is attached to.
/// - `order`: A CobOrderVariantDTO describing whether the item is single, recurring, or an exception.
///   - `.single(UUID, CobOrderDetailDTO)`: A concrete order scheduled for the week.
///   - `.recurring(UUID, CobOrderDetailDTO)`: A recurring pattern represented in this week.
///   - `.exception(UUID)`: An explicit exception indicating the absence or override of an order in this week.
///
/// Initialization:
/// - `init(week:order:)`: Creates a single-order variant for the given week from a CobOrderDTO.
/// - `init(week:recurringOrder:)`: Creates a recurring-order variant for the given week from a RecurringOrderDTO.
/// - `init(id:exceptionWeek:)`: Creates an exception variant for the given week with an explicit UUID.
/// - Deprecated: `init(exceptionWeek:)` generates a UUID automatically; prefer providing an explicit UUID.
///
/// Use cases:
/// - Populate calendar or schedule views with either concrete orders, recurring templates, or exceptions.
/// - Group, filter, or diff week-bound orders in SwiftUI lists using `id`.
/// - Pass week-contextualized orders across layers without mutating base order data.
///
/// Thread-safety:
/// - Value type with immutable properties; safe for concurrent reads.
///
/// See also:
/// - `CobOrderDTO` and `RecurringOrderDTO` for source order types.
/// - `CobOrderVariantDTO` for the underlying variant representation.
/// - `CobOrderDTO.withAssociatedWeek(_:)` to conveniently create a week-associated single order.
public struct WeekOrderVariant: Identifiable, DTO {
    
    public var id: Int { self.hashValue }
    
    public let week: WeekDTO
    public let order: CobOrderVariantDTO
    
    public init(week: WeekDTO, order: CobOrderDTO) {
        self.week = week
        self.order = .single(order.id, order.orderDetail)
    }
    
    public init(week: WeekDTO, recurringOrder: RecurringOrderDTO) {
        self.week = week
        self.order = .recurring(recurringOrder.id, recurringOrder.orderDetail)
    }
    
    @available(*, deprecated, renamed: "init(id:exceptionWeek:)", message: "Please provide a UUID for the exception")
    public init(exceptionWeek: WeekDTO) {
        self.week = exceptionWeek
        self.order = .exception(UUID())
    }
    
    public init(id: UUID, exceptionWeek: WeekDTO) {
        self.week = exceptionWeek
        self.order = .exception(id)
    }
}

/// A discriminated union representing an order variant bound to a week context.
///
/// CobOrderVariantDTO models three mutually exclusive cases that may appear in a
/// scheduling or calendar view for a given `WeekDTO`:
/// - `single(UUID, CobOrderDetailDTO)`: A concrete, one-off order instance.
/// - `recurring(UUID, CobOrderDetailDTO)`: A recurring order pattern materialized for the week.
/// - `exception(UUID)`: An explicit exception indicating no order (or an override) for the week.
///
/// Identity:
/// - Each case carries a stable `UUID` used as the variant’s identity. Access this via the
///   computed `id` property exposed in the extension.
/// - The UUID is intended to be supplied by the caller (e.g., persistence layer or API),
///   ensuring stable identity across app launches and diffable UI updates.
///
/// Payload:
/// - `single` and `recurring` include `CobOrderDetailDTO` describing the order’s contents.
/// - `exception` contains no order details by design; it represents the absence or override
///   of an order for the week.
///
/// Creation helpers (deprecated):
/// - Convenience makers that auto-generate UUIDs are deprecated to encourage explicit identity:
///   - `single(_:)`
///   - `recurring(_:)`
///   - `exception`
///   Prefer constructing the enum with explicit UUIDs for stability and traceability.
///
/// Typical usage:
/// - Drive week-based timelines or calendars where a cell may contain a concrete order, a recurring
///   placeholder realized for that week, or an explicit “no order” exception.
/// - Use `id` for SwiftUI list identity and diffing.
/// - Read `orderDetail` (optional) to access details for `single` and `recurring` cases;
///   it is `nil` for `exception`.
///
/// Thread-safety:
/// - Value semantics with immutable associated values; safe for concurrent reads.
///
/// See also:
/// - `CobOrderDTO` and `RecurringOrderDTO` as sources for constructing `single` and `recurring`.
/// - `WeekOrderVariant` for pairing this variant with a specific `WeekDTO`.
public enum CobOrderVariantDTO : DTO { case single(UUID, CobOrderDetailDTO), recurring(UUID, CobOrderDetailDTO), exception(UUID)
    
    @available(*, deprecated, renamed: "single(_:_:)", message: "Please provide a UUID for the order")
    public func single(_ detail: CobOrderDetailDTO) -> Self { .single(UUID(), detail) }
    
    @available(*, deprecated, renamed: "recurring(_:_:)", message: "Please provide a UUID for the order")
    public func recurring(_ detail: CobOrderDetailDTO) -> Self { .recurring(UUID(), detail) }
    
    @available(*, deprecated, renamed: "exception(_:)", message: "Please provide a UUID for the order exception")
    public var exception: Self { .exception(UUID()) }
}

/// A discriminated union that describes the kind of order represented within a specific week context.
///
/// CobOrderVariantDTO captures three mutually exclusive variants used to render and reason about
/// week-based schedules:
/// - single(UUID, CobOrderDetailDTO): A concrete, one-off order instance realized for a week.
/// - recurring(UUID, CobOrderDetailDTO): A recurring pattern represented in a particular week.
/// - exception(UUID): An explicit “no order” (or overridden) entry for the week.
///
/// Identity and stability:
/// - Each case carries a stable UUID used for identity (see the `id` computed property in the extension).
/// - Prefer supplying UUIDs from your persistence or API layer to ensure stable identity across launches
///   and to support diffable UI updates.
///
/// Payload:
/// - single and recurring carry a CobOrderDetailDTO that describes the order’s contents.
/// - exception intentionally carries no details; it signals absence or an override for that week.
///
/// Construction:
/// - Create values explicitly with UUIDs to maintain stable identity:
///   - .single(orderID, detail)
///   - .recurring(orderID, detail)
///   - .exception(exceptionID)
/// - Deprecated helpers exist that auto-generate UUIDs; avoid them in favor of explicit IDs.
///
/// Typical usage:
/// - Drive calendar, timeline, or planning UIs where a week cell may contain:
///   - a concrete order (single),
///   - a recurring template materialised for that week (recurring), or
///   - an explicit exception (no order).
/// - Use `id` for SwiftUI list identity and diffing.
/// - Access `orderDetail` (optional) to read details for single and recurring; it is nil for exception.
///
/// Thread-safety and semantics:
/// - Value type with immutable associated values; safe for concurrent reads.
/// - Designed for transport across app layers (DTO) without mutation.
///
/// Related types:
/// - CobOrderDTO: Source for concrete single orders.
/// - RecurringOrderDTO: Source for recurring orders.
/// - WeekOrderVariant: Pairs this variant with a specific WeekDTO for scheduling and display.
///
/// Deprecations:
/// - Auto-ID convenience makers (single(_:) / recurring(_:) / exception) are deprecated; provide explicit UUIDs.
extension CobOrderVariantDTO {
    public var id: UUID {
        switch self {
        case .single(let id, _): id
        case .recurring(let id, _): id
        case .exception(let id): id
        }
    }
    
    public var orderDetail: CobOrderDetailDTO? {
        switch self {
        case .single(_, let detail): detail
        case .recurring(_, let detail): detail
        case .exception: nil
        }
    }
}
