//
//  UIButton+.swift
//
//
//  Created by 김인섭 on 10/6/23.
//

import UIKit
import Combine

public extension UIButton {
    
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
