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
        
        let expectation = XCTestExpectation(description: "asyncThrowsMap Test")
        var expect: Int? = nil
        var arrival: Int? = nil
        
        // Given
        Just({ })
            .eraseToAnyPublisher()
        // When
            .asyncThrowsMap({ _ in
                expect = Int(Date().addingTimeInterval(3).timeIntervalSince1970)
                return try await Task.sleep(nanoseconds: 3_000_000_000)
            })
            .receive(on: DispatchQueue.main)
        // Then
            .sink( receiveValue: { _ in
                arrival = Int(Date().timeIntervalSince1970)
                XCTAssertEqual(expect, arrival)
                expectation.fulfill()
            }).store(in: &store)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_asyncMap() {
        
        let expectation = XCTestExpectation(description: "asyncMap Test")
        var expect: Int? = nil
        var arrival: Int? = nil
        
        // Given
        Just({ })
            .eraseToAnyPublisher()
        // When
            .asyncMap({ _ in
                expect = Int(Date().addingTimeInterval(3).timeIntervalSince1970)
                return try? await Task.sleep(nanoseconds: 3_000_000_000)
            })
            .receive(on: DispatchQueue.main)
        // Then
            .sink(receiveValue: { value in
                arrival = Int(Date().timeIntervalSince1970)
                XCTAssertEqual(expect, arrival)
                expectation.fulfill()
            }).store(in: &store)

        wait(for: [expectation], timeout: 10.0)
    }
}
