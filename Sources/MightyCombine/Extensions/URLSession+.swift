//
//  URLSession+.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

extension URLSession: URLSessionable {
    
    public func request<T>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        self.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
