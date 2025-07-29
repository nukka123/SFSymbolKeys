
/// Availability represents the minimum supported versions for each Apple platform.
public struct Availability: Codable {
    /// Minimum iOS version.
    public let iOS: Version
    /// Minimum macOS version.
    public let macOS: Version
    /// Minimum macCatalyst version.
    public let macCatalyst: Version
    /// Minimum tvOS version.
    public let tvOS: Version
    /// Minimum watchOS version.
    public let watchOS: Version
    /// Minimum visionOS version.
    public let visionOS: Version
}
