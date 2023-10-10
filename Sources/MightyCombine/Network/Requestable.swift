//
//  Requestable.swift
//
//
//  Created by 김인섭 on 10/11/23.
//

import Foundation
import Combine

public protocol Requestable { }

public extension Requestable where Self == URLRequest {
    
    func request<T: Decodable>(expect type: T.Type, scheduler: DispatchQueue = .main , with sesssion: URLSessionable = URLSession.shared) -> AnyPublisher<T, Error> {
        sesssion.request(self, scheduler: scheduler)
    }
}
