//
//  User.swift
//  
//
//  Created by 김인섭 on 10/7/23.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let secondId: Int?
    
    init(id: Int, login: String, secondId: Int? = nil) {
        self.id = id
        self.login = login
        self.secondId = secondId
    }
}
