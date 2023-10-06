import XCTest
import Combine
@testable import MightyCombine

final class PowerfulCombineTests: XCTestCase {
    
    // Given
    var sut: UserNetwork = .init()
    
    func test_injectFail() throws {
        
        sut.getUser = { _ in .mock(.fail(NSError())) }
        
        Task {
            // When
            let user = try? await sut.getUser("octopus").asyncThrows
            
            // Then
            XCTAssertNil(user)
        }
    }
    
    func test_injectSuccess() throws {
        
        let expect = User(login: "octopus", id: 112233)
        sut.getUser = { _ in .mock(.success(expect)) }
        
        Task {
            // When
            let user = try? await sut.getUser("octopus").asyncThrows
            
            // Then
            XCTAssertNotNil(user)
            if let user {
                XCTAssertEqual(expect.id, user.id)
            }
        }
    }
}

class UserNetwork {
    
    let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    lazy var getUser: (String) -> AnyPublisher<User, Error> = { [weak self] username in
        let urlString = "https://api.github.com/users/" + username
        let request = URLRequest(url: .init(string: urlString)!)
        return self!.session.request(request)
    }
}

struct User: Codable {
    
    let login: String
    let id: Int
}
