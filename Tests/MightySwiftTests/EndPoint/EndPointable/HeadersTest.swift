//
//  HeadersTest.swift
//
//
//  Created by 김인섭 on 10/10/23.
//

import XCTest
@testable import MightySwift
@testable import TestSource

final class HeadersTest: XCTestCase {
    
    func test_post일때_header에_contentType들어가는지() {
    
        // Given
        let expect = ["Content-Type": "application/json"]
        let sut = DefaultEndPoint
            .init(
                baseURL: "https://api.github.com",
                method: .post
            )
        
        // When
        let headers = sut.urlRequest.allHTTPHeaderFields
        
        // Then
        XCTAssertNotNil(headers)
        if let headers {
            XCTAssertEqual(headers, expect)
        }
    }
    
    func test_post이고_다른headers가_들어왔을때_contentType이랑_들어온_headers가_잘_합쳐졌는지() {
    
        // Given
        let expect = [
            "Content-Type": "application/json",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
        let sut = DefaultEndPoint
            .init(
                baseURL: "https://api.github.com",
                method: .post
            )
            .httpHeaders(["X-GitHub-Api-Version": "2022-11-28"])
        
        // When
        let headers = sut.urlRequest.allHTTPHeaderFields
        
        // Then
        XCTAssertNotNil(headers)
        if let headers {
            XCTAssertEqual(headers, expect)
        }
    }
    
    func test_post이고_contentType이_들어왔을때_들어온_contentType이_할당되는지() {
        
        // Given
        let expect = [
            "Content-Type": "application/xml",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
        let sut = DefaultEndPoint
            .init(
                baseURL: "https://api.github.com",
                method: .post
            )
            .httpHeaders(expect)
        
        // When
        let headers = sut.urlRequest.allHTTPHeaderFields
        
        // Then
        XCTAssertNotNil(headers)
        if let headers {
            XCTAssertEqual(headers, expect)
        }
    }
}
