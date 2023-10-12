//
//  Optional+.swift
//
//
//  Created by 김인섭 on 10/12/23.
//

import Foundation

public extension Optional {
    
    func replaceNil(with defaultValue: Wrapped) -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return defaultValue
        }
    }
}
