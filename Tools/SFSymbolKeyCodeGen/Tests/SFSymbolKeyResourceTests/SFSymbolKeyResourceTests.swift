//

@testable
import SFSymbolKeyResource
import Testing

struct SFSymbolKeyResourceTests {
    @Test
    func testSetup() {
        let specs: [SFSymbolKeyGroup] = SFSymbolKeyGroup.setup().sorted {
            $0.config.version < $1.config.version
        }
        #expect(specs.count == 23)
        #expect(specs.first!.config.version.string == "1.0")
        #expect(specs.last!.config.version.string == "7.0")
    }
}
