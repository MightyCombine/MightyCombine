//
//  Publisher+Test.swift
//  
//
//  Created by 김인섭 on 10/10/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class Publisher_Test: XCTestCase {

    var store = Set<AnyCancellable>()

    func test_asyncThrowsMap() {
        
        // Given
        let userNetwork = UserNetwork(session: URLSession.mockSession)
        let expectation = XCTestExpectation(description: "asyncThrowsMap Test")
        var expect: Int? = nil
        var arrival: Int? = nil
        
        userNetwork.getUser("octocat")
            .inject(.success(.init(id: 0, login: "octocat")))
            .receive(on: DispatchQueue.main)
        // When
            .asyncThrowsMap({ _ in
                expect = Int(Date().addingTimeInterval(3).timeIntervalSince1970)
                return try await Task.sleep(nanoseconds: 3_000_000_000)
            })
            .receive(on: DispatchQueue.main)
        // Then
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                arrival = Int(Date().timeIntervalSince1970)
                guard let expect, let arrival else { return }
                XCTAssert((expect...expect+1).contains(arrival))
                expectation.fulfill()
            }).store(in: &store)
        

        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_asyncThrowsMap_throw하는_경우() {
        
        // Given
        let userNetwork = UserNetwork(session: URLSession.mockSession)
        
        userNetwork.getUser("octocat")
            .inject(.success(.init(id: 0, login: "octocat")))
        // When
            .asyncThrowsMap({ _ in
                throw TestError.testError
            })
        // Then
            .sink(receiveCompletion: { completion in
                guard let error = completion.error as? TestError else { return }
                XCTAssertEqual(error, TestError.testError)
            }, receiveValue: { _ in
                
            }).store(in: &store)
    }

    func test_asyncMap() {
        
        // Given
        let userNetwork = UserNetwork(session: URLSession.mockSession)
        let expectation = XCTestExpectation(description: "asyncMap Test")
        var expect: Int? = nil
        var arrival: Int? = nil
        
        userNetwork.getUser("octocat")
            .inject(.success(.init(id: 0, login: "octocat")))
        // When
            .asyncMap({ _ in
                expect = Int(Date().addingTimeInterval(3).timeIntervalSince1970)
                return try? await Task.sleep(nanoseconds: 3_000_000_000)
            })
        // Then
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                arrival = Int(Date().timeIntervalSince1970)
                guard let expect, let arrival else { return }
                print("DEBUG", (expect...expect+1).contains(arrival))
                XCTAssert((expect...expect+1).contains(arrival), "asyncMap Test")
                expectation.fulfill()
            }).store(in: &store)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
