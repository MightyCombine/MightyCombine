//
//  UITextField+.swift
//
//
//  Created by 김인섭 on 10/6/23.
//

import UIKit
import Combine

extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { $0.object as? UITextField }
        .map { $0.text ?? "" }
        .eraseToAnyPublisher()
    }
}
