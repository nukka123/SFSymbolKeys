
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

    private func extensionDecl(_ body: () -> String) -> String {
        var code = ""
        code += "public extension SFSymbolKey {\n"
        code += body()
        code += "}\n"
        return code
    }

    private func outputAvailableVersionedKeysBlock() -> String {
        var code = ""
        code += extensionDecl {
            var body = ""
            body += """
                /// Symbol keys grouped by the OS version in which they were introduced.
                ///
                /// Only includes versions available at runtime.
                static let availableVersionedKeys: [(version: String, keys: [SFSymbolKey])] = {
                    var keys: [(String, [SFSymbolKey])] = []
            """ + "\n" + "\n"

            for group in keyGroups {
                body += """
                        if \(group.availableCheckExpr()) {
                            keys.append(("\(group.config.version.string)", SFSymbolKey.\(group.keyGroupIdentifier)))
                        } else {
                            return keys
                        }
                """ + "\n" + "\n"
            }

            body += """
                    return keys
                }()
            """ + "\n"

            return body
        }
        return code
    }

    private func outputAvailabledKeysBlock() -> String {
        var code = ""
        code += extensionDecl {
            var body = ""
            body += """
                /// All symbol keys available at runtime, regardless of version.
                static let availableKeys: [SFSymbolKey] = {
                    Self.availableVersionedKeys.flatMap { $0.keys }
                }()
            """ + "\n"
            return body
        }
        return code
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
