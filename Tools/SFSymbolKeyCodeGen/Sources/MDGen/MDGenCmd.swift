
import ArgumentParser
import Foundation
import SFSymbolKeyResource

public struct MDGenCmd: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "md-gen",
        abstract: "Generates Markdown documents.",
    )

    var outputFile: String = "../../Docs/SFSymbolVersions.md"

    public init() {}

    public func run() throws {
        let keyGroups: [SFSymbolKeyGroup] = SFSymbolKeyGroup.setup()
        let code = Self.outputSFSymbolVersions(keyGroups)
        let filePath = URL(fileURLWithPath: outputFile)
        try code.write(to: filePath, atomically: true, encoding: .utf8)
        print("Generated: \(filePath.path)")
        print("Done.")
    }

    static func outputSFSymbolVersions(_ keyGroups: [SFSymbolKeyGroup]) -> String {
        var output = "# SFSymbols Version and Availability\n\n"
        output += "| SFSymnols | iOS | macOS | macCatalyst | tvOS | watchOS | visionOS |\n"
        output += "| :--: | :--: | :--: | :--: | :--: | :--: | :--: |\n"
        for group in keyGroups {
            output += [
                "| " + group.config.version.string,
                group.config.availability.iOS.string,
                group.config.availability.macOS.string,
                group.config.availability.macCatalyst.string,
                group.config.availability.tvOS.string,
                group.config.availability.watchOS.string,
                group.config.availability.visionOS.string + " |",
            ].joined(separator: " | ") + "\n"
        }
        return output
    }
}
