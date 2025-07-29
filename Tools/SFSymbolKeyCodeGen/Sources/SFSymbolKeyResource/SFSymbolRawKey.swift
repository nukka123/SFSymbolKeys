
/// SFSymbolRawKey represents the name of an SF Symbol.
public struct SFSymbolRawKey: Hashable, Sendable {
    /// The raw name of the SF Symbol.
    public let name: String

    /// Initializes a new SF Symbol name with the given raw name.
    /// - Parameter name: The raw name of the SF Symbol.
    public init(_ name: String) {
        self.name = name
    }
}
