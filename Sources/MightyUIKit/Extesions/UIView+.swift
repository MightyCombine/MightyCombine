//
//  UIView+.swift
//
//
//  Created by 김인섭 on 10/9/23.
//

import UIKit

public extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
