//
//  MockURLSessionTest.swift
//  
//
//  Created by 김인섭 on 10/7/23.
//

import XCTest
import Combine
@testable import MightyCombine

final class MockURLSessionTest: XCTestCase {
    
    func test_StatusCode500이니까_Error를_반환하는_경우() {
        
        // Given
        let url = URL(string: "https://api.github.com/users/octopus")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        let sut = MockURLSession(response: response)
        
        Task {
            
            //  When
            let user: User? = try? await sut.request(.init(url: url)) {
                guard (200...299).contains($0.statusCode) else {
                    throw NSError(domain: "Bad StatusCode", code: $0.statusCode)
                }
            }.asyncThrows
            
            // Then
            XCTAssertNil(user)
        }
    }
    
    func test_StatusCode200이니까_Error를_반환하지않는_경우() {
        // Given
        let url = URL(string: "https://api.github.com/users/octopus")!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let sut = MockURLSession(response: response)
        
        Task {
            var result: Error?
            do {
                //  When
                let _: User? = try await sut.request(.init(url: url)) {
                    guard (200...299).contains($0.statusCode) else {
                        throw NSError(domain: "Bad StatusCode", code: $0.statusCode)
                    }
                }.asyncThrows
            } catch let error {
                result = error
            }
            XCTAssertNil(result)
        }
    }
}
