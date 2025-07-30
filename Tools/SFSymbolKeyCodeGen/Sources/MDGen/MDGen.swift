
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
