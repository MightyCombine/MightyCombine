//
//  AnyPublisher+.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public extension AnyPublisher where Failure: Error {

     var asyncThrows: Output {
        get async throws {
            try await withCheckedThrowingContinuation { continuation in
                var cancellable: AnyCancellable?
                cancellable = first()
                    .subscribe(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                        cancellable?.cancel()
                    } receiveValue: { value in
                        continuation.resume(with: .success(value))
                    }
                
            }
        }
    }
    
    func mock(_ mock: NetworkMock<Output>) -> AnyPublisher<Output, Failure> {
        switch mock {
        case .success(let model):
            return Just(model)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        case .fail(let error):
            return Fail(error: error as! Failure)
                .eraseToAnyPublisher()
        }
    }
}

