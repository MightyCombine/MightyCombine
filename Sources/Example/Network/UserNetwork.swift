//
//  UserNetwork.swift
//
//
//  Created by 김인섭 on 10/11/23.
//

import Foundation
import Combine
import MightySwift
import MightyCombine

class UserNetwork {
    
    private let baseURL = "https://api.github.com"
    private let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    static func testBuild() -> UserNetwork {
        UserNetwork(session: URLSession.mockSession)
    }
    
    lazy var getUser: (String) -> AnyPublisher<User, Error> = { username in
        EndPoint
            .init(self.baseURL)
            .urlPaths(["/users", "/\(username)"])
            .request(expect: User.self, with: self.session)
    }
}

struct User: Codable {
    
    let id: Int
    let login: String
}
