//
//  UIStackView.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 19/03/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(subviews: [UIView]?, axis: UILayoutConstraintAxis, spacing: CGFloat, alignment: UIStackViewAlignment, distribution: UIStackViewDistribution) {
        if subviews != nil {
            self.init(arrangedSubviews: subviews!)
        }else {
            self.init()
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.spacing      = spacing
        self.axis         = axis
        self.alignment    = alignment
        self.distribution = distribution
    }
    
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.backgroundColor = color
        insertSubview(subView, at: 0)
    }
}
