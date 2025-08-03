
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

        do {
            let codeGenTasks: [StaticKeysCodeGen] = keyGroups.map { StaticKeysCodeGen(keyGroup: $0) }
            for codeGenTask in codeGenTasks {
                let content = codeGenTask.outputSwiftFileContent()
                let filePath = URL(fileURLWithPath: outputDir).appendingPathComponent(codeGenTask.sourceFile)
                try content.write(to: filePath, atomically: true, encoding: .utf8)
                print("Generated: \(filePath.path)")
            }
        }

        do {
            let codeGenTask = AvailableKeysCodeGen(keyGroups: keyGroups)
            let content = codeGenTask.outputSwiftFileContent()
            let filePath = URL(fileURLWithPath: outputDir).appendingPathComponent(codeGenTask.sourceFile)
            try content.write(to: filePath, atomically: true, encoding: .utf8)
            print("Generated: \(filePath.path)")
        }

        print("Done.")
    }
}

private extension FileManager {
    func directoryExists(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}
