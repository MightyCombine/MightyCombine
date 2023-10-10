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

     var asyncThrows: Output {
        get async throws {
            try await withCheckedThrowingContinuation { continuation in
                var cancellable: AnyCancellable?
                var finishedWithoutValue = true
                cancellable = first()
                    .sink { completion in
                        switch completion {
                        case .finished:
                            if finishedWithoutValue {
                                continuation.resume(throwing: AnyPublisherError.finishedWithoutValue)
                            }
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                        cancellable?.cancel()
                    } receiveValue: { value in
                        finishedWithoutValue = false
                        continuation.resume(with: .success(value))
                    }
            }
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

enum AnyPublisherError: Error {
    case finishedWithoutValue
}
