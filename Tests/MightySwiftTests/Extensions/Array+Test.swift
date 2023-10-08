//
//  Array+Test.swift
//
//
//  Created by 김인섭 on 10/7/23.
//

import XCTest
@testable import MightySwift
@testable import TestSource

// public extension Array
final class Array_Test: XCTestCase {

    // func find<T: Equatable>(_ keyPath: KeyPath<Element, T>, value: T?) -> Element?
    func test_func_find() throws {
        
        // Given
        let users: [User] = [
            .init(id: 1, login: "A"),
            .init(id: 2, login: "B"),
            .init(id: 3, login: "C"),
            .init(id: 4, login: "D"),
            .init(id: 5, login: "E")
        ]
        
        // When
        let userWithId1 = users.find(\.id, value: 1)
        let userWithId5 = users.find(\.id, value: 5)
        let userWithId0 = users.find(\.id, value: 0) // expect nil
        let userWithLoginA = users.find(\.login, value: "A")
        let userWithLoginE = users.find(\.login, value: "E")
        let userWithLoginZ = users.find(\.login, value: "Z") // expect nil
        
        // Then
        XCTAssertNotNil(userWithId1)
        if let user = userWithId1 {
            XCTAssertEqual(user.login, "A")
        }
        
        XCTAssertNotNil(userWithId5)
        if let user = userWithId5 {
            XCTAssertEqual(user.login, "E")
        }
        
        XCTAssertNil(userWithId0)
        
        XCTAssertNotNil(userWithLoginA)
        if let user = userWithLoginA {
            XCTAssertEqual(user.id, 1)
        }
        
        XCTAssertNotNil(userWithLoginE)
        if let user = userWithLoginE {
            XCTAssertEqual(user.id, 5)
        }
        
        XCTAssertNil(userWithLoginZ)
    }
    
    // func find<T: Equatable>(_ keyPath: KeyPath<Element, T>, value: T?) -> Element?
    func test_func_find_Element가_Optional_이라서_Nil을_찾는_경우() {
        
        // Given
        let users: [User] = [
            .init(id: 1, login: "one", secondId: 5),
            .init(id: 2, login: "two", secondId: 6),
            .init(id: 3, login: "three", secondId: nil)
        ]
        
        // When
        let user = users.find(\.secondId, value: nil)
        
        // Then
        XCTAssertNotNil(user)
        if let user {
            XCTAssertEqual(user.id, 3)
        }
    }
    
    // subscript (safe index: Int) -> Element?
    func test_func_safe_subscript() {
        
        // Given
        let array = [0, 1, 2, 3, 4, 5, 6]
        
        // When
        let seventhElement = array[safe: 7]
        let thirdElement = array[safe: 3]
        
        // Then
        XCTAssertNil(seventhElement)
        XCTAssertNotNil(thirdElement)
        XCTAssertEqual(thirdElement, array[3])
    }
}
