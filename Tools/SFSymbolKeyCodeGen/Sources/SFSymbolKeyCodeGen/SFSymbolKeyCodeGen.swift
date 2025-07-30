
import ArgumentParser
import CodeGen
import Foundation
import MDGen
import SFSymbolKeyResource

/// Dev Tools for SFSymbolKeys.
///
/// To see the help, run the following command:
/// ```
/// swift run SFSymbolKeyCodeGen --help
/// ```
@main
struct SFSymbolKeyCodeGen: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "SFSymbolKeyCodeGen",
        abstract: "Dev Tools for SFSymbolKeys.",
        subcommands: [AllCmd.self, CodeGenCmd.self, MDGenCmd.self],
        defaultSubcommand: AllCmd.self,
    )
}

struct AllCmd: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "all",
        abstract: "Generates both Swift source code and Markdown documents.",
    )

    func run() throws {
        try CodeGenCmd().run()
        try MDGenCmd().run()
    }
}
