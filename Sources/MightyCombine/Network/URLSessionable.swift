//
//  URLSessionable.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public protocol URLSessionable {
    
    func request<T: Decodable>(_ urlRequest: URLRequest, scheduler: DispatchQueue) -> AnyPublisher<T, Error>
    
    @available(macOS 10.15, *)
    func request<T: Decodable>(_ urlRequest: URLRequest, scheduler: DispatchQueue, responseHandler: @escaping (_ response: HTTPURLResponse) throws -> Void) -> AnyPublisher<T, Error>
}

public extension URLSessionable {
    
    func request<T: Decodable>(_ urlRequest: URLRequest, scheduler: DispatchQueue = .main) -> AnyPublisher<T, Error> {
        request(urlRequest, scheduler: scheduler)
    }
    
    @available(macOS 10.15, *)
    func request<T: Decodable>(_ urlRequest: URLRequest, scheduler: DispatchQueue = .main, responseHandler: @escaping (_ response: HTTPURLResponse) throws -> Void) -> AnyPublisher<T, Error> {
        request(urlRequest, scheduler: scheduler, responseHandler: responseHandler)
    }
}
