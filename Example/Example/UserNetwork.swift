//
//  UserNetwork.swift
//  Example
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation
import Combine

struct UserNetwork {
    
    let session: URLSessionable
    
    init(session: URLSessionable) {
        self.session = session
    }
    
    static func testBuild() -> Self {
        let data = try? JSONEncoder().encode(User(login: "abc", id: 123))
        let session = MockURLSession(mock: .data(data!))
        return .init(session: session)
    }
    
    func getUser(username: String) -> AnyPublisher<User, Error> {
        let urlString = "https://api.github.com/users/" + username
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        return session.request(request)
    }
}
