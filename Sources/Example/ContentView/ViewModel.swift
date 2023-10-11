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
    
    let username = "octocat"
    
    func didTapButton() {
        example_AnyPublisher()
//        example_asyncThrows()
//        example_asyncMap()
//        example_asyncThrowsMap()
    }
    
    func example_AnyPublisher() {
        userNetwork
            .getUser(username)
            .sink { completion in
                print(completion)
            } receiveValue: { user in
                print(user)
            }.store(in: &store)
    }
    
    func example_asyncThrows() {
        Task {
            let user = try? await userNetwork.getUser(username).asyncThrows
            print(user)
        }
    }
    
    func example_asyncMap() {
        userNetwork
            .getUser(username)
            .asyncMap { [weak self] in
                await self?.asyncFunc($0)
            }
            .sink { completion in
                print(completion)
            } receiveValue: { id in
                print(id)
            }.store(in: &store)
    }
    
    func example_asyncThrowsMap() {
        userNetwork
            .getUser(username)
            .asyncThrowsMap { [weak self] in
                try await self?.asyncThrowsFunc($0)
            }
            .sink { completion in
                print(completion)
            } receiveValue: { id in
                print(id)
            }.store(in: &store)
    }
}

private extension ViewModel {
    
    func asyncFunc(_ user: User) async -> Int {
        do {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            return user.id
        } catch {
            return -1
        }
    }
    
    func asyncThrowsFunc(_ user: User) async throws -> Int {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        return user.id
    }
}
