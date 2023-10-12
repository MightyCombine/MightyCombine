//
//  Optional+Test.swift
//  
//
//  Created by 김인섭 on 10/12/23.
//

import XCTest

final class Optional_Test: XCTestCase {

    func test_replaceNil() {
        // Given
        let optionalValue: Int? = nil
        
        // When
        let result = optionalValue.replaceNil(with: 10)
        
        // Then
        XCTAssert(result == 10)
        XCTAssertNil(optionalValue)
    }
}
