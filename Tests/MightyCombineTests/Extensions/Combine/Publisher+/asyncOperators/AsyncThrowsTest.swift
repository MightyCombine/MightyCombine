//
//  AsyncThrowsTest.swift
//  
//
//  Created by 김인섭 on 10/6/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class AsyncThrowsTest: XCTestCase {

    func test_Empty_return_finishedWithoutValue() async {
        do {
            let _ = try await Empty<Any, Error>()
                .asyncThrows
        } catch {
            XCTAssertNotNil(error as? AnyPublisherError)
            if let error = error as? AnyPublisherError {
                XCTAssertEqual(error, AnyPublisherError.finishedWithoutValue)
            }
        }
    }
    
    func test_Error_return_Error() async {
        do {
            let _ = try await Fail<Any, TestError>(error: TestError.testError)
                .asyncThrows
        } catch {
            XCTAssertNotNil(error as? TestError)
            if let error = error as? TestError {
                XCTAssertEqual(error, TestError.testError)
            }
        }
    }
    
    func test_Value_return_Value() async {
        
        let expect = 123
        let result = try? await Just(expect)
            .setFailureType(to: Error.self)
            .asyncThrows
        XCTAssertNotNil(result)
        if let result {
            XCTAssertEqual(result, expect)
        }
    }
}
