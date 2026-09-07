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
}

extension CUID {
  static var discreteValues: Int { 1_679_616 } // base * blockSize

  static var random: String {
    .init((0 ..< discreteValues).randomElement()!, radix: base)
      .padding(toLength: blockSize, withPad: "0", startingAt: 0)
  }

  static func encode(fingerprint: String) -> String {
    String(getpid(), radix: CUID.base)
      .filled(to: fingerprintPadding)
      + String(
        fingerprint.unicodeScalars
          .filter(\.isASCII)
          .reduce(UInt32(fingerprint.count + CUID.base)) {
            $0 + $1.value
          },
        radix: CUID.base
      )
      .filled(to: fingerprintPadding)
  }
}

// MARK: - CUID + Initializer

public extension CUID {
  /// Initalizes a `CUID`.
  /// - Parameter fingerprint: Client fingerprint used to generate the id.
  ///
  init(fingerprint: String) {
    cuidString = "c"
      + String(time(nil) * 1000, radix: CUID.base)
      + String(CUID.count(), radix: CUID.base).filled(to: CUID.blockSize)
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

// MARK: Hashable

extension CUID: Hashable {}

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
