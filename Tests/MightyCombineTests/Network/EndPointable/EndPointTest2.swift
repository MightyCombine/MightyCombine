//
//  EndPointTest2.swift
//
//
//  Created by iOS신상우 on 1/24/24.
//

import XCTest
@testable import MightyCombine

final class EndPointTest2: XCTestCase {
    
    // Given
    struct EncodableBody: Codable {
        let id: Int
        let hireable: Bool
    }
    
    let baseUrl = "https://api.github.com"
    let paths = [
        "/users",
        "/octocat"
    ]
    let queries = [
        "type": "User",
        "login": "octocat"
    ]
    let headers = [
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28"
    ]
    let body: [String: Any] = [
        "id": 1,
        "hireable": false
    ]
    
    let encodableBody: EncodableBody = .init(id: 1, hireable: false)
    
    // When
    var request: URLRequest {
        EndPoint
            .init(baseUrl)
            .urlPaths(paths)
            .urlQueries(queries)
            .httpHeaders(headers)
            .httpBody(encodableBody)
            .httpMethod(.get)
            .urlRequest
    }
    
    // Then
    func test_AbosoluteUrlString() {
        
        guard let absoluteUrl = request.url?.absoluteString else { return }
        
        let expect1 = baseUrl + "/users" + "/octocat" + "?type=User&login=octocat"
        let expect2 = baseUrl + "/users" + "/octocat" + "?login=octocat&type=User"
        
        XCTAssertTrue(absoluteUrl == expect1 || absoluteUrl == expect2)
    }
    
    func test_Header() {
        guard let header = request.allHTTPHeaderFields else { return }
        XCTAssertEqual(header, headers)
    }
    
    func test_body() {
        
        guard let bodyData = request.httpBody,
              let requestBody = try? JSONDecoder().decode(EncodableBody.self, from: bodyData) else {
            XCTFail("Body is empty")
            return
        }
        
        XCTAssertEqual(requestBody.id, 1)
        XCTAssertEqual(requestBody.hireable, false)
    }
    
    func test_Method() {
        
        guard let method = request.httpMethod else { return }
        
        XCTAssertEqual(method, "GET")
    }
}
