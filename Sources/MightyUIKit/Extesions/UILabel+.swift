//
//  UILabel+.swift
//
//
//  Created by 김인섭 on 10/9/23.
//

import UIKit

public extension UILabel {
    
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    func translatesAutoresizingMaskIntoConstraints(_ state: Bool) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = state
        return self
    }
}

public extension UILabel {
    
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
    
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> Self {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    func shadowColor(_ shadowColor: UIColor?) -> Self {
        self.shadowColor = shadowColor
        return self
    }
    
    func shadowOffset(_ shadowOffset: CGSize) -> Self {
        self.shadowOffset = shadowOffset
        return self
    }
    
    func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> Self {
        self.minimumScaleFactor = minimumScaleFactor
        return self
    }
    
    func attributedText(_ attributedText: NSAttributedString?) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    func highlightedTextColor(_ highlightedTextColor: UIColor?) -> Self {
        self.highlightedTextColor = highlightedTextColor
        return self
    }
}

public extension UILabel {
    
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }
    
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    func allowsDefaultTighteningForTruncation(_ state: Bool) -> Self {
        self.allowsDefaultTighteningForTruncation = state
        return self
    }
}
