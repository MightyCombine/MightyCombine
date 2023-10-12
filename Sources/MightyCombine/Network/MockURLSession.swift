//
//  MockURLSession.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public struct MockURLSession: URLSessionable {
    
    var response: HTTPURLResponse?
    
    public init(response: HTTPURLResponse? = nil) {
        self.response = response
    }
    
    public func requestPublisher<T>(_ urlRequest: URLRequest, scheduler: DispatchQueue = DispatchQueue.main) -> AnyPublisher<T, Error> where T : Decodable {
        Empty()
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    @available(macOS 10.15, *)
    public func requestPublisher<T>(_ urlRequest: URLRequest, scheduler: DispatchQueue = DispatchQueue.main, responseHandler: @escaping (HTTPURLResponse) throws -> Void) -> AnyPublisher<T, Error> where T : Decodable {
        guard let response = response else {
            return Empty()
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        }
        
        do {
            try responseHandler(response)
            return Empty()
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        }
    }
    
    public func uploadPublisher<T>(for request: URLRequest, from bodyData: Data, scheduler: DispatchQueue = .main) -> AnyPublisher<T, Error> where T : Decodable {
        Empty()
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
        guard let response = response else {
            return Empty()
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        }
        
        do {
            try responseHandler(response)
            return Empty()
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        }
    }
}
