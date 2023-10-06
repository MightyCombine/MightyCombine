//
//  AnyPublisher+.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public extension AnyPublisher {

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
    
    func mock(_ mock: NetworkMock) -> AnyPublisher<Output, Failure> {
        
        switch mock {
        case .success(let data):
            guard let output = Output.self as? Decodable.Type,
                  let decoded = try? JSONDecoder().decode(output.self, from: data)
            else { return Empty().eraseToAnyPublisher() }
            
            return Just(decoded as! Output)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
        case .fail(let error):
            guard let error = error as? Failure
            else { return Empty().eraseToAnyPublisher() }
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
