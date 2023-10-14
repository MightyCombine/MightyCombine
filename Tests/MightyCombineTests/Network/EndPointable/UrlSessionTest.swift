//
//  UrlSessionTest.swift
//  
//
//  Created by 김인섭 on 10/15/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class UrlSessionTest: XCTestCase {

    func testExample() {
        
        // Given
        let url = URL(string: UserNetwork.baseUrl)!
        let response = HTTPURLResponse(
            url: url,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        let testSession = MockURLSession()
            .urlResponse(response)
        
        _ = EndPoint
            .init(UserNetwork.baseUrl)
            .urlPaths(["/users", "/octocat"])
        // When
            .urlSession(testSession)
        // Then
            .responseHandler({ response in
                let status = response.statusCode
                XCTAssert(status == 500)
            })
    }
}
