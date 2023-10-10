//
//  EndPointable.swift
//
//
//  Created by 김인섭 on 10/10/23.
//

import Foundation

public protocol EndPointable {
    
    var baseURL: String { get }
    var paths: [String]? { get set }
    var queries: [String: String]? { get set }
    var headers: [String: String]? { get set }
    var body: [String: Any]? { get set }
    var method: HttpMethod { get set }
}
