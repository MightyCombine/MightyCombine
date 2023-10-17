//
//  URLSession+.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

extension URLSession: URLSessionable {
    
    public static var printLog: Bool = false
    
    public static let mockSession = MockURLSession()
    
    @available(macOS 10.15, *)
    public func requestPublisher<T>(
        _ urlRequest: URLRequest,
        expect: T.Type? = nil,
        logStyle: DataLogStyle = .json,
        scheduler: DispatchQueue = .main,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> AnyPublisher<T, Error> where T : Decodable {
        if Self.printLog {
            printRequestLog(urlRequest, logStyle: logStyle)
        }
        return self.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse {
                    if Self.printLog {
                        self.printResponseLog(
                            response,
                            data: data,
                            logStyle: logStyle
                        )
                    }
                    try responseHandler?(response)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    @available(macOS 10.15, *)
    public func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        expect: T.Type? = nil,
        logStyle: DataLogStyle = .json,
        scheduler: DispatchQueue = .main,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> AnyPublisher<T, Error> {
        if Self.printLog {
            printRequestLog(request, logStyle: logStyle)
        }
        return Future<T, Error> { promise in
            self.uploadTask(with: request, from: bodyData) { data, response, error in
                do {
                    if let response = response as? HTTPURLResponse {
                        if Self.printLog {
                            self.printResponseLog(
                                response,
                                data: data,
                                logStyle: logStyle
                            )
                        }
                        try responseHandler?(response)
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

public enum DataLogStyle {
    case json, string
}
