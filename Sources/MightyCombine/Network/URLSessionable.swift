//
//  URLSessionable.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public protocol URLSessionable {
    
    func requestPublisher<T: Decodable>(
        _ urlRequest: URLRequest,
        scheduler: DispatchQueue
    ) -> AnyPublisher<T, Error>
    
    @available(macOS 10.15, *)
    func requestPublisher<T: Decodable>(
        _ urlRequest: URLRequest,
        scheduler: DispatchQueue,
        responseHandler: @escaping (_ response: HTTPURLResponse) throws -> Void
    ) -> AnyPublisher<T, Error>
    
    func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        scheduler: DispatchQueue
    ) -> AnyPublisher<T, Error>
    
    @available(macOS 10.15, *)
    func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        scheduler: DispatchQueue,
        responseHandler: @escaping (_ response: HTTPURLResponse) throws -> Void
    ) -> AnyPublisher<T, Error>
}

public extension URLSessionable {
    
    func requestPublisher<T: Decodable>(
        _ urlRequest: URLRequest,
        scheduler: DispatchQueue = .main
    ) -> AnyPublisher<T, Error> {
        requestPublisher(
            urlRequest,
            scheduler: scheduler
        )
    }
    
    @available(macOS 10.15, *)
    func requestPublisher<T: Decodable>(
        _ urlRequest: URLRequest,
        scheduler: DispatchQueue = .main,
        responseHandler: @escaping (_ response: HTTPURLResponse) throws -> Void
    ) -> AnyPublisher<T, Error> {
        requestPublisher(
            urlRequest,
            scheduler: scheduler,
            responseHandler: responseHandler
        )
    }
    
    func uploadPublisher<T>(
        for request: URLRequest,
        from bodyData: Data,
        scheduler: DispatchQueue = .main
    ) -> AnyPublisher<T, Error> where T : Decodable {
        uploadPublisher(
            for: request,
            from: bodyData,
            scheduler: scheduler
        )
    }
    
    @available(macOS 10.15, *)
    func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        scheduler: DispatchQueue = .main,
        responseHandler: @escaping (_ response: HTTPURLResponse) throws -> Void
    ) -> AnyPublisher<T, Error> {
        uploadPublisher(
            for: request,
            from: bodyData,
            scheduler: scheduler,
            responseHandler: responseHandler
        )
    }
}
