//
//  RecurringOrderException+DTO.swift
//  crumbs
//
//  Created by Christopher Wainwright on 10/10/2025.
//

import Foundation

/// A data transfer object that represents an exception to a recurring order.
///
/// Recurring order exceptions are used to denote deviations from a user's normal
/// recurring order pattern for a specific week (e.g., a skip, pause, or override).
/// This DTO is designed for transport across layers (e.g., networking, persistence)
/// and may include lightweight associated objects for convenience.
///
/// - Note: This type is immutable and safe to pass between threads.
///
/// Properties:
/// - `id`: A stable, unique identifier for the exception instance.
/// - `createdAt`: The timestamp indicating when the exception was created.
/// - `user`: An optional, lightweight representation of the user to whom this exception applies.
/// - `week`: An optional, lightweight representation of the week for which the exception is defined.
///
/// Initialiser:
/// - Initialises a new exception with its identity, creation date, and optional associated user and week.
///
/// Methods:
/// - `withAssociatedWeek(_:)`: Produces a `WeekOrderVariant` that associates this exception with a specific `WeekDTO`,
///   useful when projecting or composing week-centric domain views.
///
/// Usage:
/// - Use this DTO when decoding/encoding exception payloads or when transporting exception data
///   between application layers. Convert to domain models as needed in your business logic.
///
/// Thread Safety:
/// - All properties are value types and constants; the DTO is inherently thread-safe.
///
/// See Also:
/// - `UserDTO` for user representation.
/// - `WeekDTO` for week representation.
/// - `WeekOrderVariant` for a composed view that pairs an exception with a specific week.
public struct RecurringOrderExceptionDTO: DTO {
    public let id: UUID
    public let createdAt: Date
    public let user: UserDTO?
    public let week: WeekDTO?
    
    public init(id: UUID, createdAt: Date, user: UserDTO? = nil, week: WeekDTO? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.user = user
        self.week = week
    }
    
    public func withAssociatedWeek(_ week: WeekDTO) -> WeekOrderVariant {
        .init(id: self.id, exceptionWeek: week)
    }
}
