//
//  SelfReturnableTest.swift
//  
//
//  Created by 김인섭 on 11/1/23.
//

import XCTest
@testable import MightySwift
@testable import TestSource

extension DefaultEndPoint: SelfReturnable { }
final class DefaultViewController: UIViewController, SelfReturnable { }

final class SelfReturnableTest: XCTestCase {

    func test_struct() {
        let endpoint = DefaultEndPoint
            .init(baseURL: "https://api.github.com")
            .with(\.paths, ["/users", "/octocat"])
            .with(\.method, .get)
        
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertEqual(endpoint.paths, ["/users", "/octocat"])
    }
    
    func test_class() {
        let controller = DefaultViewController()
            .with(\.title, "Hello")
            .with(\.hidesBottomBarWhenPushed, true)
            .with(\.toolbarItems, [.init(), .init()])
        
        XCTAssertEqual(controller.title, "Hello")
        XCTAssertEqual(controller.hidesBottomBarWhenPushed, true)
        XCTAssertEqual(controller.toolbarItems?.count, 2)
    }
}
