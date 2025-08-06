/// Builds indented text blocks for structured code generation.
///
/// Use `TextBlock` to compose nested code-like structures with proper indentation.
struct TextBlock {
    private let indentLevel: Int
    private var content: [(level: Int, text: String)] = []
}

extension TextBlock {
    /// Creates a new `TextBlock` with a header and footer, nesting it under an optional parent block.
    /// The content block is executed with increased indentation.
    init(
        _ header: String,
        _ footer: String,
        parent: TextBlock? = nil,
        content: (inout TextBlock) -> Void,
    ) {
        indentLevel = (parent?.indentLevel ?? -1) + 1
        append(header, indentOffset: 0)
        content(&self)
        append(footer, indentOffset: 0)
    }

    /// Returns a nested `TextBlock` with its own header and footer.
    /// The indentation is based on the current block.
    func textBlock(
        _ header: String,
        _ footer: String,
        content: (inout TextBlock) -> Void,
    ) -> TextBlock {
        TextBlock(header, footer, parent: self, content: content)
    }

    /// Appends a string to the block, adjusting for line breaks and indentation.
    private mutating func append(_ newString: String, indentOffset: Int) {
        let lines = newString.split(separator: "\n", omittingEmptySubsequences: false)
        for line in lines {
            content.append((indentLevel + indentOffset, String(line)))
        }
    }
}

extension TextBlock {
    private static let indentString = "    "

    /// The final formatted string with proper indentation.
    var string: String {
        content.map {
            let indent = $0.text.isEmpty ? "" : String(repeating: Self.indentString, count: $0.level)
            return "\(indent)\($0.text)\n"
        }.joined()
    }
}

extension TextBlock {
    /// Appends a string as an indented line.
    static func += (lhs: inout TextBlock, rhs: String) {
        lhs.append(rhs, indentOffset: 1)
    }

    /// Appends the contents of another `TextBlock`.
    static func += (lhs: inout TextBlock, rhs: TextBlock) {
        lhs.content.append(contentsOf: rhs.content)
    }
}
