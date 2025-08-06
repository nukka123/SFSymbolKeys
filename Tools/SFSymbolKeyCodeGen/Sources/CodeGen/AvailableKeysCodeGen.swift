
import SFSymbolKeyResource

struct AvailableKeysCodeGen {
    var keyGroups: [SFSymbolKeyGroup]
}

extension SFSymbolKeyGroup {
    var versionIdentifier: String {
        "v\(config.version.underscoredString)"
    }

    func availableCheckExpr() -> String {
        "#available("
            + "iOS \(config.availability.iOS), "
            + "macOS \(config.availability.macOS), "
            + "macCatalyst \(config.availability.macCatalyst), "
            + "tvOS \(config.availability.tvOS), "
            + "watchOS \(config.availability.watchOS), "
            + "visionOS \(config.availability.visionOS), "
            + "*)"
    }
}

extension AvailableKeysCodeGen {
    var sourceFile: String {
        "SFSymbolsVersion+generated.swift"
    }

    private func headerComment() -> String {
        "// SFSymbols + utilities.\n"
    }

    private func outputAvailableVersionedKeysBlock() -> String {
        TextBlock("public extension SFSymbolKey {", "}") {
            $0 +=
                """
                /// Symbol keys grouped by the OS version in which they were introduced.
                ///
                /// Only includes versions available at runtime.
                """
            $0 += $0.textBlock("static let availableVersionedKeys: [(version: String, keys: [SFSymbolKey])] = {", "}()") {
                $0 += "var keys: [(String, [SFSymbolKey])] = []" + "\n"
                for group in keyGroups {
                    $0 +=
                        """
                        if \(group.availableCheckExpr()) {
                            keys.append(("\(group.config.version.string)", SFSymbolKey.\(group.keyGroupIdentifier)))
                        } else {
                            return keys
                        }
                        """ + "\n"
                }
                $0 += "return keys"
            }
        }.string
    }

    private func outputAvailabledKeysBlock() -> String {
        TextBlock("public extension SFSymbolKey {", "}") {
            $0 +=
                """
                /// All symbol keys available at runtime, regardless of version.
                static let availableKeys: [SFSymbolKey] = {
                    Self.availableVersionedKeys.flatMap { $0.keys }
                }()
                """
        }.string
    }

    func outputSwiftFileContent() -> String {
        var code = ""
        code += headerComment()
        code += "\n"
        code += outputAvailableVersionedKeysBlock()
        code += "\n"
        code += outputAvailabledKeysBlock()
        return code
    }
}
