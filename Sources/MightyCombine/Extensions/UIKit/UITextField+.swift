//
//  UITextField+.swift
//
//
//  Created by 김인섭 on 10/6/23.
//

#if canImport(UIKit)
import Combine
import UIKit

public extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        controlPublisher(for: .editingChanged)
            .map { _ in self.text ?? "" }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
#endif
