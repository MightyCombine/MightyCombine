//
//  URLSessionable.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public protocol URLSessionable {
    
    static var printLog: Bool { get }
    static var logReadingOption: JSONSerialization.ReadingOptions { get }
    
    @available(macOS 10.15, *)
    func requestPublisher<T: Decodable>(
        _ urlRequest: URLRequest,
        expect: T.Type?,
        scheduler: DispatchQueue,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)?
    ) -> AnyPublisher<T, Error>
    
    @available(macOS 10.15, *)
    func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        expect: T.Type?,
        scheduler: DispatchQueue,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)?
    ) -> AnyPublisher<T, Error>
}

public extension URLSessionable {
    
    func printRequestLog(_ request: URLRequest) {
        var body: Any?
        if let data = request.httpBody {
            body = try? JSONSerialization.jsonObject(with: data, options: Self.logReadingOption)
        }
        let log = """
        🛫 Network Request Log
            - absoluteURL: \(request.url?.absoluteString ?? "")
            - header: \(request.allHTTPHeaderFields ?? [:])
            - method: \(request.httpMethod ?? "")
            - body: \(body ?? "")
        """
        print(log)
    }
    
    func printResponseLog(_ response: HTTPURLResponse, data: Data?) {
        var body: Any?
        if let data = data {
            body = try? JSONSerialization.jsonObject(with: data, options: Self.logReadingOption)
        }
        let log = """
        🛬 Network Response Log
            - absoluteURL: \(response.url?.absoluteString ?? "")
            - statusCode: \(response.statusCode)
            - data: \(body ?? "")
        """
        print(log)
    }
    
    @available(macOS 10.15, *)
    func requestPublisher<T: Decodable>(
        _ urlRequest: URLRequest,
        expect: T.Type? = nil,
        scheduler: DispatchQueue = .main,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> AnyPublisher<T, Error> {
        requestPublisher(
            urlRequest,
            expect: expect,
            scheduler: scheduler,
            responseHandler: responseHandler
        )
    }
    
    @available(macOS 10.15, *)
    func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        expect: T.Type? = nil,
        scheduler: DispatchQueue = .main,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> AnyPublisher<T, Error> {
        uploadPublisher(
            for: request,
            from: bodyData,
            expect: expect,
            scheduler: scheduler,
            responseHandler: responseHandler
        )
    }
}
