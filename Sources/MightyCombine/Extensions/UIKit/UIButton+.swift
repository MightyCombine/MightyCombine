//
//  UIButton+.swift
//
//
//  Created by 김인섭 on 10/6/23.
//

import UIKit
import Combine

public extension UIButton {
    
    func eventPublisher(for event: UIControl.Event) -> AnyPublisher<Void, Never> {
        controlPublisher(for: event)
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
