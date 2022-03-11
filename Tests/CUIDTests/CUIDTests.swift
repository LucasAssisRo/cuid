@testable import CUID
import XCTest

final class CUIDTests: XCTestCase {
    func testUniqueness() throws {
        let id = UUID()
        XCTAssertTrue(
            Dictionary(grouping: (0 ..< 1_679_616).map { _ in CUID(uuid: id) }, by: \.id)
                .lazy
                .map(\.value.count)
                .filter { $0 != 1 }
                .isEmpty
        )
    }
}
