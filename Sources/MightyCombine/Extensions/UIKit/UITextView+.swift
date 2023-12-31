//
//  UITextView+.swift
//
//
//  Created by 김인섭 on 10/6/23.
//

#if canImport(UIKit)
import Combine
import UIKit

public extension UITextView {
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextView.textDidChangeNotification,
            object: self
        )
        .compactMap { $0.object as? UITextView }
        .map { $0.text ?? "" }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
     }
}
#endif
