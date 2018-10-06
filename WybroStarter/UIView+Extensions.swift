//
//  UIView+Extensions.swift
//  WybroStarter
//
//  Created by Connor Wybranowski on 10/21/17.
//  Copyright © 2017 wybro. All rights reserved.
//

import Foundation

public enum LayoutType {
    case vertical, horizontal
}

public enum FillType {
    case vertical, horizontal
}

public extension UIView {
    
    public func addSubviewForLayout(_ view: UIView) {
        self.addSubview(view.usingConstraints())
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

    public func fill(_ direction: FillType, in superview: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
        let first = NSLayoutConstraint(item: self,
                                       attribute: direction == .vertical ? .top : .leading,
                                       relatedBy: .equal,
                                       toItem: superview,
                                       attribute: direction == .vertical ? .top : .leading,
                                       multiplier: 1,
                                       constant: padding)
        let second = NSLayoutConstraint(item: self,
                                       attribute: direction == .vertical ? .bottom : .trailing,
                                       relatedBy: .equal,
                                       toItem: superview,
                                       attribute: direction == .vertical ? .bottom : .trailing,
                                       multiplier: 1,
                                       constant: -padding)
        return [first, second]
    }

    public func fill(in superview: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
        let vertical = self.fill(.vertical, in: superview, padding: padding)
        let horizontal = self.fill(.horizontal, in: superview, padding: padding)
        return [vertical, horizontal].flatMap { $0 }
    }
    
    public func addSubviewsForLayout(_ views: [UIView]) {
        views.forEach { addSubviewForLayout($0) }
    }
}

public extension Array where Element == UIView {
    
    public func fill(_ direction: FillType, in superview: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
        return self.map { $0.fill(direction, in: superview, padding: padding) }.flatMap { $0 }
    }

    public func fill(in superview: UIView, padding: CGFloat = 0) -> [NSLayoutConstraint] {
        return self.map { $0.fill(in: superview, padding: padding) }.flatMap { $0 }
    }
        
    public func center(in superview: UIView,
                       type: LayoutType,
                       offset: CGFloat = 0) -> [NSLayoutConstraint] {
        return self.map { $0.center(in: superview, type: type, offset: offset) }
    }

    public func center(in superview: UIView,
                       xOffset: CGFloat = 0,
                       yOffset: CGFloat = 0) -> [NSLayoutConstraint] {
        return self.map { $0.center(in: superview, xOffset: xOffset, yOffset: yOffset) }.flatMap { $0 }
    }
}
