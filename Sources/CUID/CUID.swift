//
//  CUID.swift
//
//
//  Created by Lucas Assis Rodrigues on 3/10/22.
//

import Foundation

// MARK: - CUID

/// Collision-resistant universal identifier.
public struct CUID {
    public let cuidString: String
}

private extension CUID {
    static var base: Int { 36 }
    static var blockSize: Int { 4 }
    static var fingerprintPadding: Int { 2 }
    static var discreteValues: Int { 1_679_616 } // base * blockSize

    private static var _count = 0
    static var count: Int {
        _count += 1
        if _count == discreteValues { _count = 0 }
        return _count
    }
}

internal extension CUID {
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
        self.cuidString = "c"
            + String(time(nil) * 1000, radix: CUID.base)
            + String(CUID.count, radix: CUID.base).filled(to: CUID.blockSize)
            + CUID.encode(fingerprint: fingerprint)
            + CUID.random
            + CUID.random
    }

    
    /// Initalizes a `CUID`.
    /// - Parameter uuid: Unique identifier to fingerprint the `CUID`.
    ///
    init(uuid: UUID) { self.init(fingerprint: uuid.uuidString) }
}

// MARK: - CUID + Hashable

extension CUID: Hashable {}

// MARK: - CUID + Identifiable

extension CUID: Identifiable {
    public var id: CUID { self }
}

// MARK: - CUID + CustomStringConvertible

extension CUID: CustomStringConvertible {
    public var description: String { cuidString }
}

// MARK: - CUID + CustomDebugStringConvertible

extension CUID: CustomDebugStringConvertible {
    public var debugDescription: String { description }
}
