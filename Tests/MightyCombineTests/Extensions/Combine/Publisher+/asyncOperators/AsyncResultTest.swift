//
//  AsyncResultTest.swift
//  
//
//  Created by 김인섭 on 12/24/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class AsyncResultTest: XCTestCase {

    func test_Success() async {
        
        let result = await Just("Value").asyncResult
        
        switch result {
        case .success(let success):
            XCTAssertEqual(success, "Value")
        case .failure(_):
            XCTFail("Failure should not return")
        }
    }
    
    func test_Failure() async {
        
        let result = await Fail<Any, TestError>(error: TestError.testError)
            .asyncResult
        
        switch result {
        case .success(_):
            XCTFail("Success should not return")
        case .failure(let failure):
            guard let failure = failure as? TestError else {
                return XCTFail("Unexpected")
            }
            XCTAssertEqual(failure, TestError.testError )
        }
    }
}
