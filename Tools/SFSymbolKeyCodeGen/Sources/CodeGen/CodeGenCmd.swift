
import ArgumentParser
import Foundation
import SFSymbolKeyResource

public struct CodeGenCmd: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "code-gen",
        abstract: "Generates Swift source code.",
    )

    var outputDir: String = "../../Sources/SFSymbolKeys/Generated/"

    public init() {}

    public func run() throws {
        guard FileManager.default.directoryExists(atPath: outputDir) else {
            throw ValidationError("Output directory does not exist: \(outputDir)")
        }

        let keyGroups: [SFSymbolKeyGroup] = SFSymbolKeyGroup.setup()

        for group in keyGroups {
            let content = group.outputSwiftFileContent()
            let filePath = URL(fileURLWithPath: outputDir).appendingPathComponent(group.sourceFile)
            try content.write(to: filePath, atomically: true, encoding: .utf8)
            print("Generated: \(filePath.path)")
        }

        do {
            let codeGen = AvailableKeysCodeGen(keyGroups: keyGroups)
            let content = codeGen.outputSwiftFileContent()
            let filePath = URL(fileURLWithPath: outputDir).appendingPathComponent(codeGen.sourceFile)
            try content.write(to: filePath, atomically: true, encoding: .utf8)
            print("Generated: \(filePath.path)")
        }

        print("Done.")
    }
}

extension SFSymbolRawKey {
    var rawIdentifier: String {
        "`\(name)`"
    }

    var stringLiteral: String {
        #""\#(name)""#
    }
}

extension SFSymbolKeyGroup {
    var sourceFile: String {
        "SFSymbolKey+v\(config.version).swift"
    }

    var keyGroupIdentifier: String {
        "keysV\(config.version.underscoredString)"
    }

    private func headerComment() -> String {
        "// SF Symbols (v\(config.version)).\n"
    }

    private func availableAttr() -> String {
        "@available("
            + "iOS \(config.availability.iOS), "
            + "macOS \(config.availability.macOS), "
            + "macCatalyst \(config.availability.macCatalyst), "
            + "tvOS \(config.availability.tvOS), "
            + "watchOS \(config.availability.watchOS), "
            + "visionOS \(config.availability.visionOS), "
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
            for rawKey in rawKeys {
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
            body += .sp4 + "static let \(keyGroupIdentifier): [SFSymbolKey] = [\n"
            for rawKey in rawKeys {
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

extension String {
    static var sp4: String {
        "    "
    }
}

extension FileManager {
    func directoryExists(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}
