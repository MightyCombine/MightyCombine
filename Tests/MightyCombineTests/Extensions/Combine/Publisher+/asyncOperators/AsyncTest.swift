//
//  AsyncTest.swift
//  
//
//  Created by 김인섭 on 10/17/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class AsyncTest: XCTestCase {

    func test_Just() async {
        let result = await Just(1)
            .receive(on: DispatchQueue.main)
            .async
        
        XCTAssertEqual(result, 1)
    }
}
