//
//  DefaultEndPoint.swift
//
//
//  Created by 김인섭 on 10/10/23.
//

import Foundation
import MightyCombine
import MightySwift

struct DefaultEndPoint: EndPointable {
    
    let baseURL: String
    var paths: [String]?
    var queries: [String : String]?
    var headers: [String : String]?
    var body: [String : Any]?
    var method: HttpMethod
    
    init(
        baseURL: String,
        paths: [String]? = nil,
        queries: [String : String]? = nil,
        headers: [String : String]? = nil,
        body: [String : Any]? = nil,
        method: HttpMethod
    ) {
        self.baseURL = baseURL
        self.paths = paths
        self.queries = queries
        self.headers = headers
        self.body = body
        self.method = method
    }
    
    var urlRequest: URLRequest {
        var endpoint = self
        if endpoint.method == .post {
            var newHeaders = ["Content-Type": "application/json"]
            if let headers = endpoint.headers {
                headers.forEach { newHeaders[$0.key] = $0.value }
            }
            endpoint.headers = newHeaders
        }
        return .init(endpoint.baseURL)
            .httpMethod(endpoint.method)
            .httpBody(endpoint.body)
            .httpHeaders(endpoint.headers)
            .urlPaths(endpoint.paths)
            .urlQueries(endpoint.queries)
    }
}
