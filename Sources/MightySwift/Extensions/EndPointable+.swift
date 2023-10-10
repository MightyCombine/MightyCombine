//
//  EndPointable+.swift
//
//
//  Created by 김인섭 on 10/10/23.
//

import Foundation
import Combine
import MightyCombine

public extension EndPointable {
    
    var urlRequest: URLRequest {
        .init(baseURL)
        .urlPaths(paths)
        .urlQueries(queries)
        .httpHeaders(headers)
        .httpBody(body)
        .httpMethod(method)
    }
    
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
    
    func request<T: Decodable>(expect type: T.Type, with sesssion: URLSessionable = URLSession.shared) -> AnyPublisher<T, Error> {
        sesssion.request(urlRequest)
    }
}
