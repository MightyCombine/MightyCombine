//
//  URLRequest+Test.swift
//  
//
//  Created by 김인섭 on 10/7/23.
//

import XCTest
import Combine
@testable import MightyCombine

final class URLRequest_Test: XCTestCase {
    
    // Given
    let request = URLRequest(url: .init(string: "https://api.github.com/users/octocat")!)
    var store = Set<AnyCancellable>()

    func testExample() throws {
        
        let mock = User(login: "octocat", id: 123)
        
        // When
        request
            .request(with: URLSession.mockSession)
            .mock(.success(mock))
            .receive(on: DispatchQueue.main)
        // Then
            .sink { completion in
                XCTAssertNil( completion.error)
            } receiveValue: { user in
                XCTAssertEqual(user.login, mock.login)
            }.store(in: &store)
    }
}
