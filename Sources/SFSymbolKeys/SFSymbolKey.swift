
/// SFSymbolKey represents a type-safe wrapper for an SF Symbol name.
public struct SFSymbolKey: Equatable, Hashable, Sendable {
    /// The raw name of the SF Symbol.
    public let name: String
}

public extension SFSymbolKey {
    /// Initializes a new SFSymbolKey with the given symbol name.
    /// - Parameter name: The raw name of the SF Symbol.
    init(_ name: String) {
        self.name = name
    }
}
