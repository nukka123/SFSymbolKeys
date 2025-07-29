//

import Foundation

/// SFSymbolKeyGroup represents a group of SF Symbols keys for a specific version,
/// including its configuration and the list of raw symbol keys.
public struct SFSymbolKeyGroup {
    /// The configuration for the SF Symbols version and its availability.
    public var config: SFSymbolConfig
    /// The list of raw symbol key strings for the version.
    public var rawKeys: [SFSymbolRawKey]
}

public extension SFSymbolKeyGroup {
    /// Generates an array of `SFSymbolKeyGroup` containing the configuration and raw key list for all available SF Symbols versions.
    /// - Returns: An array of `SFSymbolKeyGroup` for each version.
    static func setup() -> [SFSymbolKeyGroup] {
        let configs = SFSymbolConfig.loadConfigs()
        let specs = configs.map { config in
            SFSymbolKeyGroup(
                config: config,
                rawKeys: config.loadRawKeys(),
            )
        }
        return specs
    }
}

extension SFSymbolKeyGroup: CustomDebugStringConvertible {
    public var debugDescription: String {
        "SFSymbolKeyGroup{ config: \(config), rawKeys.count: \(rawKeys.count)}"
    }
}
