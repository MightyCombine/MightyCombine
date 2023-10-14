//
//  ResponseHandlerTest.swift
//  
//
//  Created by 김인섭 on 10/15/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class ResponseHandlerTest: XCTestCase {
    
    var store = Set<AnyCancellable>()

    func testExample() {
        
        // Given
        EndPoint
            .init(UserNetwork.baseUrl)
            .urlPaths(["/users", "/octocat"])
        // When
            .responseHandler { [weak self] response in
                try self?.handleResponse(response)
            }
            .requestPublisher(expect: User.self)
        // Then
            .sink { completion in
                guard let error = completion.error else { return }
                XCTAssertEqual(error as? TestError, TestError.testError)
            } receiveValue: { user in
                XCTAssert(false)
            }.store(in: &store)

        
    }
    
    func handleResponse(_ response: HTTPURLResponse) throws {
        throw TestError.testError
    }
}
