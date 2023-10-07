//
//  Array+.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation

public extension Array {
    
    func find<T: Equatable>(_ keyPath: KeyPath<Element, T>, value: T?) -> Element? {
        guard let value else { return nil }
        return first(where: { $0[keyPath: keyPath] == value })
    }
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
