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
        _ responseHandler: ((_ response: HTTPURLResponse) throws -> Void)?
    ) -> Self {
        var new = self
        new.responseHandler = responseHandler
        return new
    }
    
    func urlSession(_ session: URLSessionable?) -> Self {
        var new = self
        new.session = session
        return new
    }
    
    func requestLogStyle(_ style: LogStyle) -> Self {
        var new = self
        new.requestLogStyle = style
        return new
    }
    
    func responseLogStyle(_ style: LogStyle) -> Self {
        var new = self
        new.responseLogStyle = style
        return new
    }
    
    func requestPublisher<T: Decodable>(
        expect type: T.Type,
        scheduler: DispatchQueue = .main,
        with sesssion: URLSessionable = URLSession.shared
    ) -> AnyPublisher<T, Error> {
        
        let session = self.session ?? sesssion
        
        return session.requestPublisher(
            self.urlRequest,
            requestLogStyle: self.requestLogStyle,
            responseLogStyle: self.responseLogStyle,
            scheduler: scheduler,
            responseHandler: responseHandler
        )
    }
    
    func uploadPublisher<T: Decodable>(
        from bodyData: Data,
        expect: T.Type? = nil,
        scheduler: DispatchQueue = .main,
        with sesssion: URLSessionable = URLSession.shared
    ) -> AnyPublisher<T, Error> {
        
        let session = self.session ?? sesssion
        
        return session.uploadPublisher(
            for: self.urlRequest,
            from: bodyData,
            expect: expect,
            requestLogStyle: self.requestLogStyle,
            responseLogStyle: self.responseLogStyle,
            scheduler: scheduler,
            responseHandler: self.responseHandler
        )
    }
    
    func uploadPublisher<T: Decodable>(
        formData multipartFormData: MultiPartFormData,
        expect: T.Type? = nil,
        scheduler: DispatchQueue = .main,
        with sesssion: URLSessionable = URLSession.shared
    ) -> AnyPublisher<T, Error> {
        
        let session = self.session ?? sesssion
        
        var newHeaders = self.headers
        newHeaders?["Content-Type"] = multipartFormData.headers["Content-Type"]
        let newEndpoint = self.httpHeaders(newHeaders)
        
        return session.uploadPublisher(
            for: newEndpoint.urlRequest,
            from: multipartFormData.bodyData,
            expect: expect,
            requestLogStyle: newEndpoint.requestLogStyle,
            responseLogStyle: newEndpoint.responseLogStyle,
            scheduler: scheduler,
            responseHandler: newEndpoint.responseHandler
        )
    }
}
