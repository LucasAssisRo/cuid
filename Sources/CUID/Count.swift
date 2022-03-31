//
//  StaticCount.swift
//
//
//  Created by Lucas Assis Rodrigues on 3/13/22.
//

struct StaticCount {
    private static var count = 0
    private static var limit: Int { CUID.discreteValues }

    var value: Int { StaticCount.count }
    
    func callAsFunction() -> Int {
        Self.count += 1
        if Self.count == StaticCount.limit { StaticCount.count = 0 }
        return Self.count
    }
}
