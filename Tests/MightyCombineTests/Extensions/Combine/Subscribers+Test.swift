//
//  Subscribers+Test.swift
//  
//
//  Created by 김인섭 on 10/6/23.
//

import XCTest
import Combine
@testable import MightyCombine

final class Subscribers_Test: XCTestCase {
    
    var store = Set<AnyCancellable>()

    func test_var_error() throws {
        Fail<Any, TestError>(error: TestError.testError)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                guard let error = completion.error else { return }
                XCTAssertNotNil(error as? TestError)
                if let error = error as? TestError {
                    XCTAssertEqual(error, TestError.testError)
                }
            } receiveValue: { _ in
                
            }.store(in: &store)
    }
}
