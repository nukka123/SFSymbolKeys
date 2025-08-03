// SFSymbols + utilities.

public extension SFSymbolKey {
    /// Symbol keys grouped by the OS version in which they were introduced.
    ///
    /// Only includes versions available at runtime.
    static let availableVersionedKeys: [(version: String, keys: [SFSymbolKey])] = {
        var keys: [(String, [SFSymbolKey])] = []

        if #available(iOS 13.0, macOS 11.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, visionOS 1.0, *) {
            keys.append(("1.0", SFSymbolKey.keysV1_0))
        } else {
            return keys
        }

        if #available(iOS 13.1, macOS 11.0, macCatalyst 13.1, tvOS 13.0, watchOS 6.1, visionOS 1.0, *) {
            keys.append(("1.1", SFSymbolKey.keysV1_1))
        } else {
            return keys
        }

        if #available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *) {
            keys.append(("2.0", SFSymbolKey.keysV2_0))
        } else {
            return keys
        }

        if #available(iOS 14.2, macOS 11.0, macCatalyst 14.2, tvOS 14.2, watchOS 7.1, visionOS 1.0, *) {
            keys.append(("2.1", SFSymbolKey.keysV2_1))
        } else {
            return keys
        }

        if #available(iOS 14.5, macOS 11.3, macCatalyst 14.5, tvOS 14.5, watchOS 7.4, visionOS 1.0, *) {
            keys.append(("2.2", SFSymbolKey.keysV2_2))
        } else {
            return keys
        }

        if #available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *) {
            keys.append(("3.0", SFSymbolKey.keysV3_0))
        } else {
            return keys
        }

        if #available(iOS 15.1, macOS 12.0, macCatalyst 15.1, tvOS 15.1, watchOS 8.1, visionOS 1.0, *) {
            keys.append(("3.1", SFSymbolKey.keysV3_1))
        } else {
            return keys
        }

        if #available(iOS 15.2, macOS 12.1, macCatalyst 15.2, tvOS 15.2, watchOS 8.3, visionOS 1.0, *) {
            keys.append(("3.2", SFSymbolKey.keysV3_2))
        } else {
            return keys
        }

        if #available(iOS 15.4, macOS 12.3, macCatalyst 15.4, tvOS 15.4, watchOS 8.5, visionOS 1.0, *) {
            keys.append(("3.3", SFSymbolKey.keysV3_3))
        } else {
            return keys
        }

        if #available(iOS 16.0, macOS 13.0, macCatalyst 16.0, tvOS 16.0, watchOS 9.0, visionOS 1.0, *) {
            keys.append(("4.0", SFSymbolKey.keysV4_0))
        } else {
            return keys
        }

        if #available(iOS 16.1, macOS 13.0, macCatalyst 16.1, tvOS 16.1, watchOS 9.1, visionOS 1.0, *) {
            keys.append(("4.1", SFSymbolKey.keysV4_1))
        } else {
            return keys
        }

        if #available(iOS 16.4, macOS 13.4, macCatalyst 16.4, tvOS 16.4, watchOS 9.4, visionOS 1.0, *) {
            keys.append(("4.2", SFSymbolKey.keysV4_2))
        } else {
            return keys
        }

        if #available(iOS 17.0, macOS 14.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
            keys.append(("5.0", SFSymbolKey.keysV5_0))
        } else {
            return keys
        }

        if #available(iOS 17.1, macOS 14.1, macCatalyst 17.1, tvOS 17.1, watchOS 10.1, visionOS 1.0, *) {
            keys.append(("5.1", SFSymbolKey.keysV5_1))
        } else {
            return keys
        }

        if #available(iOS 17.2, macOS 14.2, macCatalyst 17.2, tvOS 17.2, watchOS 10.2, visionOS 1.1, *) {
            keys.append(("5.2", SFSymbolKey.keysV5_2))
        } else {
            return keys
        }

        if #available(iOS 17.4, macOS 14.4, macCatalyst 17.4, tvOS 17.4, watchOS 10.4, visionOS 1.1, *) {
            keys.append(("5.3", SFSymbolKey.keysV5_3))
        } else {
            return keys
        }

        if #available(iOS 17.6, macOS 14.6, macCatalyst 17.6, tvOS 17.6, watchOS 10.6, visionOS 1.3, *) {
            keys.append(("5.4", SFSymbolKey.keysV5_4))
        } else {
            return keys
        }

        if #available(iOS 18.0, macOS 15.0, macCatalyst 18.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            keys.append(("6.0", SFSymbolKey.keysV6_0))
        } else {
            return keys
        }

        if #available(iOS 18.1, macOS 15.1, macCatalyst 18.1, tvOS 18.1, watchOS 11.1, visionOS 2.1, *) {
            keys.append(("6.1", SFSymbolKey.keysV6_1))
        } else {
            return keys
        }

        if #available(iOS 18.2, macOS 15.2, macCatalyst 18.2, tvOS 18.2, watchOS 11.2, visionOS 2.2, *) {
            keys.append(("6.2", SFSymbolKey.keysV6_2))
        } else {
            return keys
        }

        if #available(iOS 18.4, macOS 15.4, macCatalyst 18.4, tvOS 18.4, watchOS 11.4, visionOS 2.4, *) {
            keys.append(("6.3", SFSymbolKey.keysV6_3))
        } else {
            return keys
        }

        if #available(iOS 18.5, macOS 15.5, macCatalyst 18.5, tvOS 18.5, watchOS 11.5, visionOS 2.5, *) {
            keys.append(("6.4", SFSymbolKey.keysV6_4))
        } else {
            return keys
        }

        if #available(iOS 26.0, macOS 26.0, macCatalyst 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
            keys.append(("7.0", SFSymbolKey.keysV7_0))
        } else {
            return keys
        }

        return keys
    }()
}

public extension SFSymbolKey {
    /// All symbol keys available at runtime, regardless of version.
    static let availableKeys: [SFSymbolKey] = {
        Self.availableVersionedKeys.flatMap { $0.keys }
    }()
}
