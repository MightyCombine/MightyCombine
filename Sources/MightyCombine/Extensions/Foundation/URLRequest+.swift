//
//  URLRequest+.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation
import Combine

public extension URLRequest {
    
    func request<T: Decodable>(expect type: T.Type, scheduler: DispatchQueue = .main , with sesssion: URLSessionable = URLSession.shared) -> AnyPublisher<T, Error> {
        sesssion.request(self, scheduler: scheduler)
    }
}
