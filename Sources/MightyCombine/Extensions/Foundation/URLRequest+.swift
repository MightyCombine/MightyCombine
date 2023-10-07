//
//  URLRequest+.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation
import Combine

public extension URLRequest {
    
    func request<T: Decodable>(with sesssion: URLSessionable = URLSession.shared) -> AnyPublisher<T, Error> {
        sesssion.request(self)
    }
}
