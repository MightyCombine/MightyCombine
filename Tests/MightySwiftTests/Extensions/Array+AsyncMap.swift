//
//  Array_AsynMap.swift
//  
//
//  Created by 김인섭 on 7/9/24.
//

import XCTest
@testable import TestSource

final class Array_AsyncMap: XCTestCase {


    func test() async {
        let result = await User.users.asyncMap { await $0.asnycTask }
        XCTAssertEqual(result, User.users)
    }
}
