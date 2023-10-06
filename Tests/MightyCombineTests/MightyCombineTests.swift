import XCTest
@testable import MightyCombine

final class PowerfulCombineTests: XCTestCase {
    
    // Given
    let session = URLSession.mockSession
    let url = URL(string: "https://api.github.com/users/octocat")!
    var urlRequest: URLRequest { .init(url: url) }
    
    func test_injectFail() throws {
        Task {
            // When
            let user: User? = try? await session.request(urlRequest)
                .mock(.fail(NSError()))
                .asyncThrows
            
            // Then
            XCTAssertNil(user)
        }
    }
    
    func test_injectSuccess() throws {
        Task {
            // When
            let expect = User(login: "octocat", id: 20506834)
            let user: User? = try? await session.request(urlRequest)
                .mock(.success(expect))
                .asyncThrows
            
            // Then
            XCTAssertNotNil(user)
            if let user {
                XCTAssertEqual(expect.id, user.id)
            }
        }
    }
}

struct User: Codable {
    
    let login: String
    let id: Int
}
