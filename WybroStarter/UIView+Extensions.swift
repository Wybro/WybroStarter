//
//  UIView+Extensions.swift
//  WybroStarter
//
//  Created by Connor Wybranowski on 10/21/17.
//  Copyright © 2017 wybro. All rights reserved.
//

import Foundation

public extension UIView {
    
    public enum LayoutType {
        case vertical, horizontal
    }
    
    public func center(in superview: UIView,
                       type: LayoutType,
                       offset: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self,
                                  attribute: (type == .horizontal) ? .centerX : .centerY,
                                  relatedBy: .equal,
                                  toItem: superview,
                                  attribute: (type == .horizontal) ? .centerX : .centerY,
                                  multiplier: 1,
                                  constant: offset)
    }
    
    /**
     Centers the view in the provided superview vertically and horizontally,
     with optional offset.
    */
    public func center(in superview: UIView,
                       xOffset: CGFloat = 0,
                       yOffset: CGFloat = 0) -> [NSLayoutConstraint] {
        let vertical = center(in: superview, type: .vertical, offset: yOffset)
        let horizontal = center(in: superview, type: .horizontal, offset: xOffset)
        return [vertical, horizontal]
    }
    
    public func usingConstraints() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
