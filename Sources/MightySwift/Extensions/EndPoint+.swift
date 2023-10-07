//
//  EndPoint+.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation

public extension EndPoint {
    
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
}
