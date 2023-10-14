//
//  EndPointable+.swift
//
//
//  Created by 김인섭 on 10/10/23.
//

import Foundation
import Combine
import MightySwift

public extension EndPointable {
    
    func urlPaths(_ paths: [String]?) -> Self {
        var new = self
        new.paths = paths
        return new
    }
    
    func urlQueries(_ queries: [String: String]?) -> Self {
        var new = self
        new.queries = queries
        return new
    }
    
    func httpHeaders(_ headers: [String: String]?) -> Self {
        var new = self
        new.headers = headers
        return new
    }
    
    func httpBody(_ body: [String: Any]?) -> Self {
        var new = self
        new.body = body
        return new
    }
    
    func httpMethod(_ method: HttpMethod) -> Self {
        var new = self
        new.method = method
        return new
    }
    
    func responseHandler(
        _ responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? = nil
    ) -> Self {
        var new = self
        new.responseHandler = responseHandler
        return new
    }
    
    func requestPublisher<T: Decodable>(
        expect type: T.Type,
        scheduler: DispatchQueue = .main,
        with sesssion: URLSessionable = URLSession.shared
    ) -> AnyPublisher<T, Error> {
        sesssion.requestPublisher(
            self.urlRequest,
            scheduler: scheduler,
            responseHandler: responseHandler
        )
    }
}
