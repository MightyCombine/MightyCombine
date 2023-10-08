//
//  URLSession+.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

extension URLSession: URLSessionable {
    
    public static let mockSession = MockURLSession()
    
    public func request<T>(_ urlRequest: URLRequest, scheduler: DispatchQueue = .main) -> AnyPublisher<T, Error> where T : Decodable {
        self.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    public func request<T>(_ urlRequest: URLRequest, scheduler: DispatchQueue = .main,  responseHandler: @escaping (HTTPURLResponse) throws -> Void) -> AnyPublisher<T, Error> where T : Decodable {
        self.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse {
                    try responseHandler(response)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
}
