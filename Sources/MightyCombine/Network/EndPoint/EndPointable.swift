//
//  EndPointable.swift
//
//
//  Created by 김인섭 on 10/10/23.
//

import Foundation
import Combine
import MightySwift

public protocol EndPointable {
    
    var baseURL: String { get }
    var paths: [String]? { get set }
    var queries: [String: String]? { get set }
    var headers: [String: String]? { get set }
    var body: [String: Any]? { get set }
    var method: HttpMethod { get set }
    var responseHandler: ((_ response: HTTPURLResponse) throws -> Void)? { get set }
    var urlRequest: URLRequest { get }
}
