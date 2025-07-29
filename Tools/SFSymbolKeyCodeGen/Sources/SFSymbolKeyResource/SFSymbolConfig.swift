//

import Foundation

/// SFSymbolConfig represents the configuration for a specific version of SF Symbols and its platform availability.
public struct SFSymbolConfig: Codable {
    /// The version of SF Symbols.
    public var version: Version
    /// The platform availability information for this version.
    public var availability: Availability
}

public extension SFSymbolConfig {
    static var configsFile: String {
        "configs.json"
    }

    static func loadConfigs() -> [SFSymbolConfig] {
        guard let url = Bundle.module.url(forResource: configsFile, withExtension: nil) else {
            fatalError("config.json not found in Resource folder.")
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([SFSymbolConfig].self, from: data)
        } catch {
            fatalError("Failed to load or decode config.json: \(error)")
        }
    }
}

public extension SFSymbolConfig {
    var rawKeyFile: String {
        "v\(version).txt"
    }

    func loadRawKeys() -> [SFSymbolRawKey] {
        guard let url = Bundle.module.url(forResource: rawKeyFile, withExtension: nil) else {
            fatalError("Couldn't find \(rawKeyFile) in bundle.")
        }
        do {
            return try String(contentsOf: url, encoding: .utf8)
                .components(separatedBy: .newlines)
                .filter { !$0.isEmpty }
                .map { SFSymbolRawKey($0) }
        } catch {
            fatalError("Failed to load. : \(error)")
        }
    }
}
