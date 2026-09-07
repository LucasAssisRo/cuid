import Synchronization

struct StaticCount {
  private static let count = Atomic<UInt64>(0)
  private static var limit: UInt64 { UInt64(CUID.discreteValues) }

  var value: Int {
    Int(StaticCount.count.load(ordering: .relaxed) % StaticCount.limit)
  }

  func callAsFunction() -> Int {
    Int(StaticCount.count.wrappingAdd(1, ordering: .relaxed).oldValue % StaticCount.limit)
  }
}
