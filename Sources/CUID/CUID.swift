import Foundation

// MARK: - CUID

/// Collision-resistant universal identifier.
///
/// A `CUID` is monotonically increasing, so identifiers generated later sort
/// after earlier ones. Uniqueness across devices relies on the fingerprint
/// given at creation, which should be stable for the installation.
public struct CUID {
  /// The identifier in its textual form, always prefixed with `c`.
  public let cuidString: String
}

private extension CUID {
  static var base: Int { 36 }
  static var blockSize: Int { 4 }
  static var fingerprintPadding: Int { 2 }
  static let count = StaticCount()
  static let origin = (instant: ContinuousClock.now, date: Date.now)

  static let hostname: String = {
    var buffer = [UInt8](repeating: 0, count: Int(NI_MAXHOST))
    guard gethostname(&buffer, buffer.count) == 0 else { return "" }
    return String(decoding: buffer.prefix { $0 != 0 }, as: UTF8.self)
  }()

  static var milliseconds: Int {
    Int(origin.date.timeIntervalSince1970 * 1000)
      + Int((ContinuousClock.now - origin.instant) / .milliseconds(1))
  }
}

extension CUID {
  static var discreteValues: Int { 1_679_616 } // base * blockSize

  static var random: String {
    .init((0 ..< discreteValues).randomElement()!, radix: base)
      .fitted(to: blockSize)
  }

  static func encode(fingerprint: String) -> String {
    String(getpid(), radix: CUID.base)
      .fitted(to: fingerprintPadding)
      + String(
        fingerprint.utf16
          .reduce(UInt64(fingerprint.utf16.count + CUID.base)) { $0 + UInt64($1) },
        radix: CUID.base,
      )
      .fitted(to: fingerprintPadding)
  }
}

// MARK: - CUID + Initializer

public extension CUID {
  /// Initalizes a `CUID` fingerprinted with the host name of the machine.
  ///
  init() {
    self.init(fingerprint: CUID.hostname)
  }

  /// Initalizes a `CUID`.
  /// - Parameter fingerprint: Client fingerprint used to generate the id.
  ///
  init(fingerprint: String) {
    cuidString = "c"
      + String(CUID.milliseconds, radix: CUID.base)
      + String(CUID.count(), radix: CUID.base).fitted(to: CUID.blockSize)
      + CUID.encode(fingerprint: fingerprint)
      + CUID.random
      + CUID.random
  }

  /// Initalizes a `CUID`.
  /// - Parameter uuid: Unique identifier to fingerprint the `CUID`.
  ///
  init(uuid: UUID) {
    self.init(fingerprint: uuid.uuidString)
  }
}

// MARK: Equatable

extension CUID: Equatable {}

// MARK: Hashable

extension CUID: Hashable {}

// MARK: Sendable

extension CUID: Sendable {}

// MARK: Identifiable

extension CUID: Identifiable {
  /// The identifier itself, since a `CUID` is already unique.
  public var id: CUID { self }
}

// MARK: CustomStringConvertible

extension CUID: CustomStringConvertible {
  /// The identifier in its textual form.
  public var description: String { cuidString }
}

// MARK: CustomDebugStringConvertible

extension CUID: CustomDebugStringConvertible {
  /// The identifier in its textual form.
  public var debugDescription: String { description }
}
