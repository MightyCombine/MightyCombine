//
//  UIButton+.swift
//
//
//  Created by 김인섭 on 10/9/23.
//

import SwiftUI

public extension UIButton {
    
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    func translatesAutoresizingMaskIntoConstraints(_ state: Bool) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = state
        return self
    }
}

public extension UIButton {
    
    func titleLabelFont(_ font: UIFont?) -> Self {
        self.titleLabel?.font = font
        return self
    }
    
    func setTitleColor(color: UIColor?, state: UIControl.State) -> Self {
        self.setTitleColor(color, for: state)
        return self
    }
    
    func setTitle(title: String?, state: UIControl.State) -> Self {
        self.setTitle(title, for: state)
        return self
    }
    
    func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
}

public extension UIButton {
    
    func isEnabled(_ isEnable: Bool) -> Self {
        self.isEnabled = isEnable
        return self
    }
    
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    func isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }
}

public extension UIButton {
    
    func layerMasksToBounds(_ masksToBounds: Bool) -> Self {
        self.layer.masksToBounds = masksToBounds
        return self
    }
    
    func layerCornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        return self
    }
}
