
import Foundation
import SFSymbolKeyResource

extension SFSymbolRawKey {
    var rawIdentifier: String {
        "`\(name)`"
    }

    var stringLiteral: String {
        #""\#(name)""#
    }
}

extension SFSymbolKeyGroup {
    var keyGroupIdentifier: String {
        "keysV\(config.version.underscoredString)"
    }
}

extension String {
    static var sp4: String {
        "    "
    }
}
