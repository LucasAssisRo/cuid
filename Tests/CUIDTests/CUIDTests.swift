@testable import CUID
import Foundation
import Testing

private struct `CUID tests` {
  private let id = UUID()

  @Test private func `generates a distinct identifier on every call`() {
    #expect(
      Dictionary(grouping: (0 ..< CUID.discreteValues).map { _ in CUID(uuid: id) }, by: \.id)
        .lazy
        .map(\.value.count)
        .contains(where: { $0 != 1 }) == false,
    )
  }

  @Test private func `generates a distinct identifier when called concurrently`() async {
    let cuids = await withTaskGroup(of: CUID.self) { group in
      for _ in 0 ..< CUID.discreteValues {
        group.addTask { CUID(uuid: id) }
      }
      return await group.reduce(into: []) { $0 += CollectionOfOne($1) }
    }
    #expect(Set(cuids).count == CUID.discreteValues)
  }
}
