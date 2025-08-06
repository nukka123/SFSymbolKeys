
import SFSymbolKeyResource

struct StaticKeysCodeGen {
    var keyGroup: SFSymbolKeyGroup
}

extension StaticKeysCodeGen {
    var sourceFile: String {
        "SFSymbolKey+v\(keyGroup.config.version).swift"
    }

    private func headerComment() -> String {
        "// SF Symbols (v\(keyGroup.config.version)).\n"
    }

    private func availableAttr() -> String {
        "@available("
            + "iOS \(keyGroup.config.availability.iOS), "
            + "macOS \(keyGroup.config.availability.macOS), "
            + "macCatalyst \(keyGroup.config.availability.macCatalyst), "
            + "tvOS \(keyGroup.config.availability.tvOS), "
            + "watchOS \(keyGroup.config.availability.watchOS), "
            + "visionOS \(keyGroup.config.availability.visionOS), "
            + "*)\n"
    }

    private func outputStaticKeysDeclBlock() -> String {
        var code = ""
        code += availableAttr()
        code += TextBlock("public extension SFSymbolKey {", "}") {
            for rawKey in keyGroup.rawKeys {
                $0 += "static let \(rawKey.rawIdentifier) = Self(\(rawKey.stringLiteral))"
            }
        }.string
        return code
    }

    private func outputKeyGroupDeclBlock() -> String {
        var code = ""
        code += availableAttr()
        code += TextBlock("public extension SFSymbolKey {", "}") {
            $0 += $0.textBlock("static let \(keyGroup.keyGroupIdentifier): [SFSymbolKey] = [", "]") {
                for rawKey in keyGroup.rawKeys {
                    $0 += ".\(rawKey.rawIdentifier),"
                }
            }
        }.string
        return code
    }

    func outputSwiftFileContent() -> String {
        var code = ""
        code += headerComment()
        code += "\n"
        code += outputStaticKeysDeclBlock()
        code += "\n"
        code += outputKeyGroupDeclBlock()
        return code
    }
}
