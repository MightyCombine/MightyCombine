//
//  AnyPublisher+.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public extension AnyPublisher {
    
    static func inject<T>(_ mock: Result<T, Error>) -> AnyPublisher<T, Error> {
        switch mock {
        case .success(let model):
            return Just(model)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    func inject(_ mock: Result<Output, Failure>) -> AnyPublisher<Output, Failure> {
        switch mock {
        case .success(let model):
            return Just(model)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
