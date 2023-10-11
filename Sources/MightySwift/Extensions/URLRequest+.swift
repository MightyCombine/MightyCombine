//
//  URLRequest+.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation

public extension URLRequest {
    
    init(_ baseURL: String) {
        self.init(url: URL(string: baseURL)!)
    }
    
    func urlPaths(_ paths: [String]?) -> Self {
        guard let paths = paths,
              let url = self.url
        else { return self }
        var baseUrl = url.absoluteString
        paths.forEach { baseUrl += $0 }
        var request = self
        request.url = URL(string: baseUrl)!
        return request
    }
    
    func urlQueries(_ queries: [String: String]?) -> Self {
        guard let queries = queries 
        else { return self }
        var request = self
        let url = request.url!
        var components = URLComponents(string: url.absoluteString)!
        var queryItems: [URLQueryItem] = []
        queries.forEach {
            queryItems.append(.init(name: $0.key, value: $0.value))
        }
        components.queryItems = queryItems
        request.url = components.url!
        return request
    }
    
    func httpMethod(_ method: HttpMethod) -> Self {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }
    
    func httpBody(_ body: [String: Any]?) -> Self {
        guard let body = body
        else { return self }
        var request = self
        let data = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = data
        return request
    }
    
    func httpHeaders(_ headers: [String: String]?) -> Self {
        guard let headers = headers
        else { return self }
        var request = self
        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
}
