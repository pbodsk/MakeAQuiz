import Foundation
public protocol ModelIdentifiable: Codable {
    associatedtype T: Codable

    var value: T { get }

    init(value: T)
}

public extension ModelIdentifiable {
    init(from decoder: Decoder) throws {
        try self.init(
            value: decoder
                .singleValueContainer()
                .decode(T.self)
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
