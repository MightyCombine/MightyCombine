//
//  File.swift
//  
//
//  Created by 김인섭 on 10/9/23.
//

import UIKit

public extension UILabel {
    
    func text(_ text: String?) -> UILabel {
        self.text = text
        return self
    }
    
    func font(_ font: UIFont?) -> UILabel {
        self.font = font
        return self
    }
    
    func textColor(_ textColor: UIColor) -> UILabel {
        self.textColor = textColor
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> UILabel {
        self.textAlignment = textAlignment
        return self
    }
    
    func numberOfLines(_ numberOfLines: Int) -> UILabel {
        self.numberOfLines = numberOfLines
        return self
    }
    
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> UILabel {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    func shadowColor(_ shadowColor: UIColor?) -> UILabel {
        self.shadowColor = shadowColor
        return self
    }
    
    func shadowOffset(_ shadowOffset: CGSize) -> UILabel {
        self.shadowOffset = shadowOffset
        return self
    }
    
    func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> UILabel {
        self.minimumScaleFactor = minimumScaleFactor
        return self
    }
    
    func attributedText(_ attributedText: NSAttributedString?) -> UILabel {
        self.attributedText = attributedText
        return self
    }
    
    func highlightedTextColor(_ highlightedTextColor: UIColor?) -> UILabel {
        self.highlightedTextColor = highlightedTextColor
        return self
    }
    
    func translatesAutoresizingMaskIntoConstraints(_ state: Bool) -> UILabel {
        self.translatesAutoresizingMaskIntoConstraints = state
        return self
    }
}

public extension UILabel {
    
    func isHidden(_ isHidden: Bool) -> UILabel {
        self.isHidden = isHidden
        return self
    }
    
    func isHighlighted(_ isHighlighted: Bool) -> UILabel {
        self.isHighlighted = isHighlighted
        return self
    }
    
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> UILabel {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    func allowsDefaultTighteningForTruncation(_ state: Bool) -> UILabel {
        self.allowsDefaultTighteningForTruncation = state
        return self
    }
}
