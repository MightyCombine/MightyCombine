import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class NetworkMockTest: XCTestCase {
    
    // Given
    let sut: UserNetwork = .init()
    
    func test_injectFail() throws {
        
        sut.getUser = { _ in .inject(.fail(NSError())) }
        
        Task {
            // When
            let user = try? await sut.getUser("octopus").asyncThrows
            
            // Then
            XCTAssertNil(user)
        }
    }
    
    func test_injectSuccess() throws {
        
        let mockData = User(id: 112233, login: "octopus")
        sut.getUser = { _ in .inject(.success(mockData)) }
        
        Task {
            // When
            let user = try? await sut.getUser("octopus").asyncThrows
            
            // Then
            XCTAssertNotNil(user)
            if let user {
                XCTAssertEqual(mockData.id, user.id)
            }
        }
    }
}
