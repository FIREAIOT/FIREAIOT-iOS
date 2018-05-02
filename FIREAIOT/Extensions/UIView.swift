//
//  UIView.swift
//  ManDoPick
//
//  Created by Saleem on 20/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

extension UIView {
    open func anchor(
        top: NSLayoutYAxisAnchor?,
        right: NSLayoutXAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        left: NSLayoutXAxisAnchor?,
        topConstant: CGFloat,
        rightConstant: CGFloat,
        bottomConstant: CGFloat,
        leftConstant:CGFloat
        ){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
    }
    
    open func anchorCenterXToSuperview() {
        guard let anchor = superview?.centerXAnchor else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: anchor)
        ])
    }
    
    open func anchorCenterYToSuperview() {
        guard let anchor = superview?.centerYAnchor else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: anchor)
        ])
    }
    
    open func set(height: CGFloat) -> NSLayoutConstraint {
        let anchor = heightAnchor.constraint(equalToConstant: height)
        anchor.isActive = true
        return anchor
    }
    
    open func set(width: CGFloat) -> NSLayoutConstraint {
        let anchor = widthAnchor.constraint(equalToConstant: width)
        anchor.isActive = true
        return anchor
    }

    open func set(top: NSLayoutYAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        let anchor = topAnchor.constraint(equalTo: top, constant: constant)
        anchor.isActive = true
        return anchor
    }
    
    open func set(right: NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        let anchor = rightAnchor.constraint(equalTo: right, constant: constant)
        anchor.isActive = true
        return anchor
    }
    
    open func set(bottom: NSLayoutYAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        let anchor = bottomAnchor.constraint(equalTo: bottom, constant: constant)
        anchor.isActive = true
        return anchor
    }
    
    open func set(left: NSLayoutXAxisAnchor, constant: CGFloat) -> NSLayoutConstraint {
        let anchor = leftAnchor.constraint(equalTo: left, constant: constant)
        anchor.isActive = true
        return anchor
    }
    
    func setGradient(colors : [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.startPoint = CGPoint(x: 1, y: 0)
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setGradient(colors : [UIColor], with opacity: Float) {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.opacity = opacity
        self.layer.insertSublayer(gradient, at: 0)
    }
}
