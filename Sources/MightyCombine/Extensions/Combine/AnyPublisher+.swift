//
//  AnyPublisher+.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public extension AnyPublisher {
    
    static func inject<T>(_ mock: NetworkMock<T>) -> AnyPublisher<T, Error> {
        switch mock {
        case .success(let model):
            return Just(model)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .fail(let error):
            return Fail(error: error).eraseToAnyPublisher()
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
    
    func inject(_ mock: NetworkMock<Output>) -> AnyPublisher<Output, Failure> {
        switch mock {
        case .success(let model):
            return Just(model)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        case .fail(let error):
            guard let error = error as? Failure
            else { return Empty().eraseToAnyPublisher() }
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func asyncMap<T>(_ transform: @escaping (Output) async -> T) -> Publishers.FlatMap<Future<T, Failure>, Self> {
         flatMap { value in
             Future { promise in
                 Task {
                     let output = await transform(value)
                     promise(.success(output))
                 }
             }
         }
     }
    
    func asyncThrowsMap<T>(_ transform: @escaping (Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Self> {
         flatMap { value in
             Future { promise in
                 Task {
                     do {
                         let output = try await transform(value)
                         promise(.success(output))
                     } catch let error {
                         promise(.failure(error))
                     }
                 }
             }
         }
     }
}

enum AnyPublisherError: Error {
    case finishedWithoutValue
}
