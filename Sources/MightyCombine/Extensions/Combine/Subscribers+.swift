//
//  Subscribers+.swift
//
//
//  Created by 김인섭 on 10/6/23.
//

import Combine

public extension Subscribers.Completion {
    
    var error: Failure? {
        guard case let .failure(failure) = self
        else { return nil }
        return failure
    }
}
