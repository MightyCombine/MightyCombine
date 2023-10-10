//
//  AnyPublisher+Test.swift
//  
//
//  Created by 김인섭 on 10/6/23.
//

import XCTest
import Combine
@testable import MightyCombine
@testable import TestSource

final class AnyPublisher_Test: XCTestCase {
    
    var store = Set<AnyCancellable>()

    func test_func_inject() throws {
        
        let expectInt = 123
        
        Empty<Int, Error>()
            .eraseToAnyPublisher()
            .inject(.success(expectInt))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                XCTAssertNil(completion.error)
            } receiveValue: { result in
                XCTAssertEqual(result, expectInt)
            }.store(in: &store)

        let expectError = TestError.testError
        
        Empty<Int, TestError>()
            .eraseToAnyPublisher()
            .inject(.fail(expectError))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                XCTAssertNotNil(completion.error as? TestError)
                if let error = completion.error as? TestError {
                    XCTAssertEqual(error, expectError)
                }
            } receiveValue: { _ in
                
            }.store(in: &store)
    }
    
    func test_asyncThrowsMap() {
        
        // Given
        let userNetwork = UserNetwork(session: URLSession.mockSession)
        let expectation = XCTestExpectation(description: "asyncThrowsMap Test")
        var expect: Int? = nil
        var arrival: Int? = nil
        
        userNetwork.getUser("octocat")
            .inject(.success(.init(id: 0, login: "octocat")))
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
                XCTAssertEqual(expect, arrival)
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
            .receive(on: DispatchQueue.main)
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
            .receive(on: DispatchQueue.main)
        // Then
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                arrival = Int(Date().timeIntervalSince1970)
                XCTAssertEqual(expect, arrival)
                expectation.fulfill()
            }).store(in: &store)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
