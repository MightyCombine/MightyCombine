//
//  User.swift
//  
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int
    let login: String
    let secondId: Int?
    
    init(id: Int, login: String, secondId: Int? = nil) {
        self.id = id
        self.login = login
        self.secondId = secondId
    }
}

extension User {
    
    static let users: [User] = [
        .init(id: 1, login: "A"),
        .init(id: 2, login: "B"),
        .init(id: 3, login: "C"),
        .init(id: 4, login: "D"),
        .init(id: 5, login: "E")
    ]
    
    var asnycTask: Self {
        get async {
            try? await Task.sleep(nanoseconds: 100_000_000)
            return self
        }
    }
}
