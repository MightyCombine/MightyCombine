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
    public static var requestLogStyle: LogStyle = .json
    public static var responseLogStyle: LogStyle = .json
    
    public static var decoder: JSONDecoder = JSONDecoder()
    
    public static let mockSession = MockURLSession()
    
    @available(macOS 10.15, *)
    public func requestPublisher<T>(
        _ urlRequest: URLRequest,
        expect: T.Type? = nil,
        requestLogStyle: LogStyle = URLSession.requestLogStyle,
        responseLogStyle: LogStyle = URLSession.responseLogStyle,
        scheduler: DispatchQueue = .main,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> AnyPublisher<T, Error> where T : Decodable {
        printRequestLog(urlRequest, logStyle: requestLogStyle)
        return self.dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse {
                    self.printResponseLog(
                        response, data: data, logStyle: responseLogStyle
                    )
                    try responseHandler?(response)
                }
                return data
            }
            .decode(type: T.self, decoder: Self.decoder)
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
    
    @available(macOS 10.15, *)
    public func uploadPublisher<T: Decodable>(
        for request: URLRequest,
        from bodyData: Data,
        expect: T.Type? = nil,
        requestLogStyle: LogStyle = URLSession.requestLogStyle,
        responseLogStyle: LogStyle = URLSession.responseLogStyle,
        scheduler: DispatchQueue = .main,
        responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> AnyPublisher<T, Error> {
        printRequestLog(request, logStyle: requestLogStyle)
        return Future<T, Error> { promise in
            self.uploadTask(with: request, from: bodyData) { data, response, error in
                do {
                    if let response = response as? HTTPURLResponse {
                        self.printResponseLog(
                            response, data: data, logStyle: responseLogStyle
                        )
                        try responseHandler?(response)
                    }
                    if let error = error {
                        throw error
                    } else if let data = data {
                        let decodedData = try Self.decoder.decode(T.self, from: data)
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
