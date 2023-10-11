//
//  ViewModel.swift
//
//
//  Created by 김인섭 on 10/11/23.
//

import Foundation
import Combine

class ViewModel {
    
    private let userNetwork = UserNetwork()
    private var store = Set<AnyCancellable>()
    
    func didTapButton() {
        userNetwork
            .getUser("octocat")
            .sink { completion in
                print(completion)
            } receiveValue: { user in
                print(user)
            }.store(in: &store)
    }
}
