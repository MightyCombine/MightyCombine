//
//  UIButton+.swift
//
//
//  Created by 김인섭 on 10/9/23.
//

import SwiftUI

public extension UIButton {
    
    var titleColor: (UIColor?, UIControl.State) -> UIButton {{ color, state in
        self.setTitleColor(color, for: state)
        return self
    }}
    
    var labelFont: (UIFont?) -> UIButton {{ font in
        self.titleLabel?.font = font
        return self
    }}
    
    func backgroundColor(_ color: UIColor?) -> UIButton {
        self.backgroundColor = color
        return self
    }
    
    func translatesAutoresizingMaskIntoConstraints(_ state: Bool) -> UIButton {
        self.translatesAutoresizingMaskIntoConstraints = state
        return self
    }
    
    func tag(_ tag: Int) -> UIButton {
        self.tag = tag
        return self
    }
    
    func frame(_ frame: CGRect) -> UIButton {
        self.frame = frame
        return self
    }
}

public extension UIButton {
    
    func isEnabled(_ isEnable: Bool) -> UIButton {
        self.isEnabled = isEnable
        return self
    }
    
    func isHidden(_ isHidden: Bool) -> UIButton {
        self.isHidden = isHidden
        return self
    }
    
    func isSelected(_ isSelected: Bool) -> UIButton {
        self.isSelected = isSelected
        return self
    }
}

public extension UIButton {
    
    var layerMasksToBounds: (Bool) -> UIButton {{ masksToBounds in
        self.layer.masksToBounds = masksToBounds
        return self
    }}
    
    var layerCornerRadius: (CGFloat) -> UIButton {{ cornerRadius in
        self.layer.cornerRadius = cornerRadius
        return self
    }}
}
