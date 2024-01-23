//
//  Subscribers+Test.swift
//  
//
//  Created by 김인섭 on 10/6/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class Subscribers_Test: XCTestCase {
    
    var store = Set<AnyCancellable>()

    func test_var_error() throws {
        Fail<Any, TestError>(error: TestError.testError)
            .sink { completion in
                let error = completion.error
                XCTAssertNotNil(error)
                XCTAssertEqual(error, TestError.testError)
            } receiveValue: { _ in
                
            }.store(in: &store)
    }
}
