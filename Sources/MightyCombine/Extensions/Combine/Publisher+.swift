//
//  Publisher+.swift
//
//
//  Created by 김인섭 on 10/10/23.
//

import Foundation
import Combine

extension Publisher {
    
    func asyncMap<T>(_ transform: @escaping (Output) async -> T) -> Publishers.FlatMap<Future<T, Failure>, Self> {
         flatMap { value in
             Future { promise in
                 Task {
                     let output = await transform(value)
                     promise(.success(output))
                 }
             }
         }
     }
    
    func asyncThrowsMap<T>(_ transform: @escaping (Output) async throws -> T) -> Publishers.FlatMap<Future<T, Error>, Self> {
         flatMap { value in
             Future { promise in
                 Task {
                     do {
                         let output = try await transform(value)
                         promise(.success(output))
                     } catch let error {
                         promise(.failure(error))
                     }
                 }
             }
         }
     }
}
