//
//  AsnycOptionalThrowsTest.swift
//  
//
//  Created by 김인섭 on 10/16/23.
//

import XCTest
import Combine
@testable import MightyCombine

final class AsnycOptionalThrowsTest: XCTestCase {

    func test_Just_return_Value() throws {
        Task {
            let value = await Just("Value")
                .receive(on: DispatchQueue.main)
                .asyncOptionalTry
            
            XCTAssertEqual(value, "Value")
        }
    }
    
    func test_Fail_return_nil() throws {
        Task {
            let value = await Just("Value")
                .receive(on: DispatchQueue.main)
                .asyncOptionalTry
            
            XCTAssertNil(value)
        }
    }
}
