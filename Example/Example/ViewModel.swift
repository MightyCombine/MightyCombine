//
//  ViewModel.swift
//  Example
//
//  Created by 김인섭 on 10/5/23.
//

import Foundation

class ViewModel {
    
    let userNetwork = UserNetwork.testBuild()
    
    func didTapButton() {
        Task {
            let result = try? await userNetwork.getUser(username: "octopus").asyncThrows
            print(result)
        }
    }
}

