//
//  RequestTest.swift
//  
//
//  Created by 김인섭 on 10/11/23.
//

import XCTest
import Combine
@testable import MightySwift
@testable import TestSource

final class RequestTest: XCTestCase {
    
    var store = Set<AnyCancellable>()

    // Given
    let sut = EndPoint
        .init("https://api.github.com")
    // When
        .request(
            expect: User.self,
            with: URLSession.mockSession
        )
        .inject(.success(.init(id: 0, login: "octocat")))

    func test_func_request() {
        
        // Then
        sut.sink { completion in
            if completion.error != nil {
                XCTAssert(false)
            }
        } receiveValue: { user in
            XCTAssertEqual(user.id, 0)
            XCTAssertEqual(user.login, "octocat")
        }.store(in: &store)
    }
}
