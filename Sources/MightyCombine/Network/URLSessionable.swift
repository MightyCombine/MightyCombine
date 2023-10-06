//
//  URLSessionable.swift
//  
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

public protocol URLSessionable {
    
    func request<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error>
    
    func request<T: Decodable>(_ urlRequest: URLRequest, responseHandler: @escaping (_ response: HTTPURLResponse) throws -> Void) -> AnyPublisher<T, Error>
}
