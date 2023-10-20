//
//  AsyncReplaceErrorTest.swift
//  
//
//  Created by 김인섭 on 10/17/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class AsyncReplaceErrorTest: XCTestCase {

    func test_Just_same() async {
        let result = await Just(1)
            .receive(on: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .asyncReplaceError(with: 10)
        
        XCTAssertEqual(result, 1)
    }
    
    func test_Fail_replace() async {
        let result = await Fail(error: TestError.testError)
            .receive(on: DispatchQueue.main)
            .asyncReplaceError(with: 10)
        
        XCTAssertEqual(result, 10)
    }
}
