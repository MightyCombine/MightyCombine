//
//  MockURLSession.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

//public struct MockURLSession: URLSessionable {
//    
//    public func request<T>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
//        Empty()
//            .eraseToAnyPublisher()
//    }
//}

public struct MockURLSession: URLSessionable, Mockable {
    
    public var mock: Mock
    
    init(mock: Mock) {
        self.mock = mock
    }
    
    public func request<T>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        if let data = mock.data {
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return Just(decoded)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } catch let error {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        } else if let error = mock.error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        } else {
            return Empty()
                .eraseToAnyPublisher()
        }
    }
}

public protocol Mockable {
    var mock: Mock { get }
}

public struct Mock {
    var data: Data?
    var error: Error?
}
