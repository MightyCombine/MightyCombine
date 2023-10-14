//
//  UserNetwork.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation
import Combine
import MightyCombine

class UserNetwork {
    
    static let baseUrl = "https://api.github.com"
    let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    lazy var getUser: (String) -> AnyPublisher<User, Error> = { username in
        let urlString = UserNetwork.baseUrl + "/users/" + username
        let request = URLRequest(url: .init(string: urlString)!)
        return self.session.requestPublisher(request)
    }
}
