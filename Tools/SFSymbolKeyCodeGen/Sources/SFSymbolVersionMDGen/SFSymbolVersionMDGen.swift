
import ArgumentParser
import Foundation
import SFSymbolKeyResource

@main
struct SFSymbolVersionMDGen: ParsableCommand {
    var outputFile: String = "../../Docs/SFSymbolVersions.md"

    mutating func run() throws {
        let keyGroups: [SFSymbolKeyGroup] = SFSymbolKeyGroup.setup()
        let code = Self.outputSFSymbolVersions(keyGroups)
        let filePath = URL(fileURLWithPath: outputFile)
        try code.write(to: filePath, atomically: true, encoding: .utf8)
        print("Done.")
    }

    static func outputSFSymbolVersions(_ keyGroups: [SFSymbolKeyGroup]) -> String {
        var output = "# SFSymbols Version and Availability\n\n"
        output += "| SFSymnols | iOS | macOS | macCatalyst | tvOS | watchOS | visionOS |\n"
        output += "| :--: | :--: | :--: | :--: | :--: | :--: | :--: |\n"
        for group in keyGroups {
            output += [
                "| " + group.config.version,
                group.config.availability.iOS,
                group.config.availability.macOS,
                group.config.availability.macCatalyst,
                group.config.availability.tvOS,
                group.config.availability.watchOS,
                group.config.availability.visionOS + " |",
            ].joined(separator: " | ") + "\n"
        }
        return output
    }
}
