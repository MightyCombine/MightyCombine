//
//  URLRequest+Test.swift
//  
//
//  Created by 김인섭 on 10/7/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class URLRequest_Test: XCTestCase {
    
    // Given
    let urlRequest = URLRequest(url: .init(string: "https://api.github.com/users/octocat")!)
    var store = Set<AnyCancellable>()

    func test_func_request() throws {
        
        let mock = User(id: 123, login: "octocat")
        
        // When
        urlRequest
            .request(expect: User.self, with: URLSession.mockSession)
            .inject(.success(mock))
            .receive(on: DispatchQueue.main)
        // Then
            .sink { completion in
                XCTAssertNil( completion.error)
            } receiveValue: { user in
                XCTAssertEqual(user.login, mock.login)
            }.store(in: &store)
    }
}
