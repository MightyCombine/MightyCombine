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
    
    public func requestPublisher<T>(
        _ urlRequest: URLRequest,
        scheduler: DispatchQueue = .main
    ) -> AnyPublisher<T, Error> where T : Decodable {
        self.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    @available(macOS 10.15, *)
    public func requestPublisher<T>(
        _ urlRequest: URLRequest,
        scheduler: DispatchQueue = .main,
        responseHandler: @escaping (HTTPURLResponse) throws -> Void
    ) -> AnyPublisher<T, Error> where T : Decodable {
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
    
    public func uploadPublisher<T>(
        for request: URLRequest,
        from bodyData: Data,
        scheduler: DispatchQueue = .main
    ) -> AnyPublisher<T, Error> where T : Decodable {
        return Future<T, Error> { promise in
            self.uploadTask(with: request, from: bodyData) { data, response, error in
                do {
                    if let error = error {
                        throw error
                    } else if let data = data {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(decodedData))
                    }
                } catch {
                    promise(.failure(error))
                }
            }.resume()
        }
        .receive(on: scheduler)
        .eraseToAnyPublisher()
    }
    
    @available(macOS 10.15, *)
    public func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        scheduler: DispatchQueue = .main,
        responseHandler: @escaping (_ response: HTTPURLResponse) throws -> Void
    ) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            self.uploadTask(with: request, from: bodyData) { data, response, error in
                do {
                    if let response = response as? HTTPURLResponse {
                        try responseHandler(response)
                    }
                    if let error = error {
                        throw error
                    } else if let data = data {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(decodedData))
                    }
                } catch {
                    promise(.failure(error))
                }
            }.resume()
        }
        .receive(on: scheduler)
        .eraseToAnyPublisher()
    }
}
