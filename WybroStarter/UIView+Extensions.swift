//
//  UIView+Extensions.swift
//  Wybro
//
//  Created by Connor Wybranowski on 10/21/17.
//  Copyright © 2017 wybro. All rights reserved.
//

import Foundation

extension UIView {
    
    enum LayoutType {
        case vertical, horizontal
    }
    
    func center(in superview: UIView, type: LayoutType) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self,
                                  attribute: (type == .horizontal) ? .centerX : .centerY,
                                  relatedBy: .equal,
                                  toItem: superview,
                                  attribute: (type == .horizontal) ? .centerX : .centerY,
                                  multiplier: 1,
                                  constant: 0)
    }
}
