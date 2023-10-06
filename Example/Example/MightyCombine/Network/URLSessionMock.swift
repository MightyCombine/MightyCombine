//
//  MockURLSession.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public struct MockURLSession: URLSessionable, Mockable {
    
    public var mock: Mock
    
    init(mock: Mock) {
        self.mock = mock
    }
    
    public func request<T>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        
        switch mock {
        case .data(let data):
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return Just(decoded)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch let error {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        case .error(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}

public protocol Mockable {
    var mock: Mock { get }
}

public enum Mock {
    case data(Data),
         error(Error)
}
