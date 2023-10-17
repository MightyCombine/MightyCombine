//
//  Publisher+.swift
//
//
//  Created by 김인섭 on 10/10/23.
//

import Foundation
import Combine

public extension Publisher {
    
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
                        continuation.resume(returning: value)
                    }
            }
        }
    }
    
    var asyncOptionalTry: Output? {
        get async {
            await withCheckedContinuation { continuation in
                var cancellable: AnyCancellable?
                var finishedWithoutValue = true
                cancellable = first()
                    .sink(receiveCompletion: { compltion in
                        switch compltion {
                        case .finished:
                            if finishedWithoutValue {
                                continuation.resume(returning: nil)
                            }
                        case .failure(_):
                            continuation.resume(returning: nil)
                        }
                        cancellable?.cancel()
                    }, receiveValue: { value in
                        finishedWithoutValue = false
                        continuation.resume(returning: value)
                    })
            }
        }
    }
    
    func asyncReplaceError(with replaceValue: Output) async -> Output? {
        await withCheckedContinuation { continuation in
            var cancellable: AnyCancellable?
            var finishedWithoutValue = true
            cancellable = first()
                .sink(receiveCompletion: { compltion in
                    switch compltion {
                    case .finished:
                        if finishedWithoutValue {
                            continuation.resume(returning: replaceValue)
                        }
                    case .failure(_):
                        continuation.resume(returning: replaceValue)
                    }
                    cancellable?.cancel()
                }, receiveValue: { value in
                    finishedWithoutValue = false
                    continuation.resume(returning: value)
                })
        }
    }
        
    
    @available(macOS 10.15, *)
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
    
    @available(macOS 10.15, *)
    func asyncThrowsMap<T>(_ transform: @escaping (Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }
}

public extension Publisher where Failure == Never {
    
    var async: Output {
        get async {
            await withCheckedContinuation { continuation in
                var cancellable: AnyCancellable?
                cancellable = first()
                    .sink(receiveValue: { value in
                        continuation.resume(returning: value)
                        cancellable?.cancel()
                    })
            }
        }
    }
}

enum AnyPublisherError: Error {
    case finishedWithoutValue
}
