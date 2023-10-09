//
//  UITextField+.swift
//
//
//  Created by 김인섭 on 10/9/23.
//

import UIKit

public extension UITextField {
    
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    func translatesAutoresizingMaskIntoConstraints(_ state: Bool) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = state
        return self
    }
}

public extension UITextField {

    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autocorrectionType
        return self
    }
    
    func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }
    
    func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Self {
        self.returnKeyType = returnKeyType
        return self
    }
    
    func clearButtonMode(_ clearButtonMode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = clearButtonMode
        return self
    }
    
    func contentVerticalAlignment(_ contentVerticalAlignment: UIControl.ContentVerticalAlignment) -> Self {
        self.contentVerticalAlignment = contentVerticalAlignment
        return self
    }
    
    func becomeFirstResponder(_ state: Bool) -> Self {
        if state {
            self.becomeFirstResponder()
        }
        return self
    }
    
    func borderStyle(_ borderStyle: UITextField.BorderStyle) -> Self {
        self.borderStyle = borderStyle
        return self
    }
    
    func placeholder(_ placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
}


public extension UITextField {
    
    func clearsOnBeginEditing(_ state: Bool) -> Self {
        self.clearsOnBeginEditing = clearsOnBeginEditing
        return self
    }
}
