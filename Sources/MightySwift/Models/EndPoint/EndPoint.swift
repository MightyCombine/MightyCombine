//
//  File.swift
//  
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation

public struct EndPoint: EndPointable {
    
    public let baseURL: String
    public var paths: [String]?
    public var queries: [String: String]?
    public var headers: [String: String]?
    public var body: [String: Any]?
    public var method: HttpMethod
    
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
    
    public var urlRequest: URLRequest {
        .init(baseURL)
        .urlPaths(paths)
        .urlQueries(queries)
        .httpHeaders(headers)
        .httpBody(body)
        .httpMethod(method)
    }
}
