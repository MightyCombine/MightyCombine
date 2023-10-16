//
//  AsnycOptionalThrowsTest.swift
//  
//
//  Created by 김인섭 on 10/16/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class AsnycOptionalThrowsTest: XCTestCase {

    func test_Just_return_Value() {
        Task {
            let value = await Just("Value")
                .receive(on: DispatchQueue.main)
                .asyncOptionalTry
            
            XCTAssertEqual(value, "Value")
        }
    }
    
    func test_Fail_return_nil() {
        Task {
            let value = await Fail<Any, TestError>(error: TestError.testError)
                .receive(on: DispatchQueue.main)
                .asyncOptionalTry
            
            XCTAssertNil(value)
        }
    }
    
    func test_Empty_return_nil() {
        Task {
            let value = await Empty<Any, Never>()
                .receive(on: DispatchQueue.main)
                .setFailureType(to: Error.self)
                .asyncOptionalTry
            
            XCTAssertNil(value)
        }
    }
}
