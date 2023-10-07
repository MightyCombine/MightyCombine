//
//  File.swift
//  
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation

public struct EndPoint {
    
    let baseURL: String
    var paths: [String]?
    var queries: [String: String]?
    var headers: [String: String]?
    var body: [String: Any]?
    var method: HttpMethod
    
    public init(
        _ baseURL: String,
        paths: [String]? = nil,
        queries: [String: String]? = nil,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
        method: HttpMethod = .get
    ) {
        self.baseURL = baseURL
        self.paths = paths
        self.queries = queries
        self.headers = headers
        self.body = body
        self.method = method
    }
    
    public var urlRequest: () -> URLRequest {{
        .init(baseURL)
        .urlPaths(paths)
        .urlQueries(queries)
        .httpHeaders(headers)
        .httpBody(body)
        .httpMethod(method)
    }}
}
