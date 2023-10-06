//
//  UITextField+.swift
//
//
//  Created by 김인섭 on 10/6/23.
//

import UIKit
import Combine

public extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        controlPublisher(for: .editingChanged)
            .map { _ in self.text ?? "" }
            .eraseToAnyPublisher()
    }
}
