//
//  MockURLSession.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public struct MockURLSession: URLSessionable {
    
    public static var printLog: Bool = false
    public static var requestLogStyle: LogStyle = .json
    public static var responseLogStyle: LogStyle = .json
    
    var response: HTTPURLResponse?
    
    public init(response: HTTPURLResponse? = nil) {
        self.response = response
    }
}

extension MockURLSession {
    
    public func urlResponse(_ response: HTTPURLResponse?) -> Self {
        var new = self
        new.response = response
        return new
    }
    
    @available(macOS 10.15, *)
    public func requestPublisher<T>(
        _ urlRequest: URLRequest,
        expect: T.Type? = nil,
        requestLogStyle: LogStyle = MockURLSession.requestLogStyle,
        responseLogStyle: LogStyle = MockURLSession.responseLogStyle,
        scheduler: DispatchQueue = DispatchQueue.main,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> AnyPublisher<T, Error> where T : Decodable {
        guard let response = response else {
            return Empty()
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        }
        do {
            try responseHandler?(response)
            return Empty()
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        }
    }
    
    @available(macOS 10.15, *)
    public func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        expect: T.Type? = nil,
        requestLogStyle: LogStyle = MockURLSession.requestLogStyle,
        responseLogStyle: LogStyle = MockURLSession.responseLogStyle,
        scheduler: DispatchQueue = .main,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> AnyPublisher<T, Error> {
        guard let response = response else {
            return Empty()
                .receive(on: scheduler)
                .eraseToAnyPublisher()
        }
        do {
            try responseHandler?(response)
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
