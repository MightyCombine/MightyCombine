//
//  MockURLSession.swift
//
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

struct MockURLSession: URLSessionable {
    
    func request<T>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
        Empty()
            .eraseToAnyPublisher()
    }
}
