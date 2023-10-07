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
