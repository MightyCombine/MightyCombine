//
//  UISwitch+.swift
//
//
//  Created by 김인섭 on 11/7/23.
//

#if canImport(UIKit)
import UIKit
import Combine

public extension UISwitch {
    var onOffPublisher: AnyPublisher<Bool, Never> {
        controlPublisher(for: .valueChanged)
            .map { $0 as! UISwitch }
            .map { $0.isOn }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
#endif
