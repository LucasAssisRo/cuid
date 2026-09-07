@testable import CUID
import XCTest

final class CUIDTests: XCTestCase {
  func testUniqueness() {
    let id = UUID()
    XCTAssertTrue(
      Dictionary(grouping: (0 ..< 1_679_616).map { _ in CUID(uuid: id) }, by: \.id)
        .lazy
        .map(\.value.count)
        .contains(where: { $0 != 1 }) == false
    )
  }
}
