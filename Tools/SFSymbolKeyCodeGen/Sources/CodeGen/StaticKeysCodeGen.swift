
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

    private func extensionDecl(_ body: () -> String) -> String {
        var code = ""
        code += "public extension SFSymbolKey {\n"
        code += body()
        code += "}\n"
        return code
    }

    private func outputStaticKeysDeclBlock() -> String {
        var code = ""
        code += availableAttr()
        code += extensionDecl {
            var body = ""
            for rawKey in keyGroup.rawKeys {
                body +=
                    .sp4 + "static let \(rawKey.rawIdentifier) = Self(\(rawKey.stringLiteral))\n"
            }
            return body
        }
        return code
    }

    private func outputKeyGroupDeclBlock() -> String {
        var code = ""
        code += availableAttr()
        code += extensionDecl {
            var body = ""
            body += .sp4 + "static let \(keyGroup.keyGroupIdentifier): [SFSymbolKey] = [\n"
            for rawKey in keyGroup.rawKeys {
                body += .sp4 + .sp4 + ".\(rawKey.rawIdentifier),\n"
            }
            body += .sp4 + "]\n"
            return body
        }
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
