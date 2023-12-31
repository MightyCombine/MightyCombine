//
//  URLRequest+.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation
import Combine

extension URLRequest {
    
    @available(macOS 10.15, *)
    public func requestPublisher<T: Decodable>(
        expect type: T.Type,
        requestLogStyle: LogStyle = URLSession.requestLogStyle,
        responseLogStyle: LogStyle = URLSession.responseLogStyle,
        scheduler: DispatchQueue = .main,
        with sesssion: URLSessionable = URLSession.shared
    ) -> AnyPublisher<T, Error> {
        sesssion.requestPublisher(
            self,
            requestLogStyle: requestLogStyle,
            responseLogStyle: responseLogStyle,
            scheduler: scheduler
        )
    }
}
