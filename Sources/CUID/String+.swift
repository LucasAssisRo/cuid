//
//  String+.swift
//
//
//  Created by Lucas Assis Rodrigues on 3/10/22.
//

import Foundation

internal extension String {
    func filled(to length: Int) -> String { padding(toLength: length, withPad: "0", startingAt: 0) }
}
