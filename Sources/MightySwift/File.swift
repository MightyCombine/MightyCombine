//
//  File.swift
//  
//
//  Created by 김인섭 on 11/1/23.
//

import Foundation

public protocol SelfReturnable {
    associatedtype ReturnType
    func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> ReturnType
}

public extension SelfReturnable {
    func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}
