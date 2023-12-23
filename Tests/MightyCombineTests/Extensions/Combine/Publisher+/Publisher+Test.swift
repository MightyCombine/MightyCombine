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
        var expect: Int? = nil
        var arrival: Int? = nil
        
        userNetwork.getUser("octocat")
            .inject(.success(.init(id: 0, login: "octocat")))
        // When
            .asyncThrowsMap({ _ in
                expect = Int(Date().addingTimeInterval(3).timeIntervalSince1970)
                return try await Task.sleep(nanoseconds: 3_000_000_000)
            })
        // Then
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                arrival = Int(Date().timeIntervalSince1970)
                guard let expect = expect,
                      let arrival = arrival
                else { return }
                XCTAssert((expect...expect+1).contains(arrival))
            }).store(in: &store)
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
                guard let expect = expect,
                      let arrival = arrival
                else { return }
                print("DEBUG", (expect...expect+1).contains(arrival))
                XCTAssert((expect...expect+1).contains(arrival), "asyncMap Test")
            }).store(in: &store)
    }
    
    func test_withUnretained() {
        
        // Initialize the controller and optional weak reference
        let controller = UIViewController()
        weak var weakController: UIViewController? = controller
        
        Just(10)
            .withUnretained(controller)
            .sink { (self, value) in
                XCTAssertNotNil(self)
            }.store(in: &store)

        XCTAssertNotNil(weakController)
    }
    
    func test_mapToResult_Success() {

        Just("Value")
            .setFailureType(to: TestError.self)
            .mapToResult()
            .sink { result in
                switch result {
                case .success(let success):
                    XCTAssertEqual(success, "Value")
                case .failure(_):
                    XCTFail("Should not return Fail")
                }
            }.store(in: &store)
    }
    
    func test_mapToResult_Failure() {
        
        Fail<Any, TestError>(error: TestError.testError)
            .mapToResult()
            .sink { result in
                switch result {
                case .success(_):
                    XCTFail("Should not return Success")
                case .failure(let failure):
                    XCTAssertEqual(failure, TestError.testError)
                }
            }.store(in: &store)
    }
}
