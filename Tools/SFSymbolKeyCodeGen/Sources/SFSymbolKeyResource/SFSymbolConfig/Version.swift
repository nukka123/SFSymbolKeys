
/// Represents a version number with major and minor components.
public struct Version: Hashable {
    /// The major version number.
    public var major: Int
    /// The minor version number.
    public var minor: Int
}

public extension Version {
    /// A string representation of the version with an underscore separator (e.g., "1_2").
    var underscoredString: String {
        "\(major)_\(minor)"
    }

    /// A string representation of the version with a dot separator (e.g., "1.2").
    var string: String {
        "\(major).\(minor)"
    }
}

extension Version: LosslessStringConvertible {
    /// Initializes a `Version` instance from a string representation (e.g., "1.2").
    /// - Parameter string: The string to parse. Returns `nil` if the format is invalid.
    public init?(_ string: String) {
        let components = string.split(separator: ".").compactMap { Int($0) }
        guard components.count == 2 else {
            return nil
        }
        major = components[0]
        minor = components[1]
    }

    /// The string representation of the version, conforming to `CustomStringConvertible`.
    public var description: String {
        string
    }
}

extension Version: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let versionString = try container.decode(String.self)
        guard let version = Version(versionString) else {
            throw DecodingError.dataCorruptedError(
                in: container, debugDescription: "Invalid version string format: \(versionString)",
            )
        }
        self = version
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

extension Version: Comparable {
    public static func < (lhs: Version, rhs: Version) -> Bool {
        (lhs.major, lhs.minor) < (rhs.major, rhs.minor)
    }
}
