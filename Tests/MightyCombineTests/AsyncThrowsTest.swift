//
//  AsyncThrowsTest.swift
//  
//
//  Created by 김인섭 on 10/6/23.
//

import XCTest
import Combine
@testable import MightyCombine

final class AsyncThrowsTest: XCTestCase {

    func test_Empty_return_finishedWithoutValue() {
        Task {
            do {
                let _ = try await Empty<Any, Error>()
                    .eraseToAnyPublisher()
                    .asyncThrows
            } catch let error {
                XCTAssertNotNil(error as? AnyPublisherError)
                if let error = error as? AnyPublisherError {
                    XCTAssertEqual(error, AnyPublisherError.finishedWithoutValue)
                }
            }
        }
    }
    
    func test_Error_return_Error() {
        Task {
            do {
                let _ = try await Fail<Any, TestError>(error: TestError.testError)
                    .eraseToAnyPublisher()
                    .asyncThrows
            } catch let error {
                XCTAssertNotNil(error as? TestError)
                if let error = error as? TestError {
                    XCTAssertEqual(error, TestError.testError)
                }
            }
        }
    }
    
    func test_Value_return_Value() {
        
        let expect = 123
        Task {
            let result = try? await Just(expect)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
                .asyncThrows
            XCTAssertNotNil(result)
            if let result {
                XCTAssertEqual(result, expect)
            }
        }
    }
}

enum TestError: Error {
    case testError
}
