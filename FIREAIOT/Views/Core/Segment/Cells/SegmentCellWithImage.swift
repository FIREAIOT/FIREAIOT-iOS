//
//  SegmentCellWithImage.swift
//  FIREAIOT
//
//  Created by Saleem on 24/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

final class SegmentCellWithImage: SegmentCell {
    
    override func setupConstraintsForSubviews() {
        super.setupConstraintsForSubviews()
        guard let imageContainerView = imageContainerView else {
            return
        }
        
        let views = ["imageContainerView": imageContainerView]
        
        // main constraints
        
        let segmentImageViewlHorizontConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-[imageContainerView]-|",
            options: [],
            metrics: nil,
            views: views)
        NSLayoutConstraint.activate(segmentImageViewlHorizontConstraint)
        
        // custom constraints
        
        topConstraint = NSLayoutConstraint(
            item: imageContainerView,
            attribute: .top,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .top,
            multiplier: 1,
            constant: padding
        )
        topConstraint?.isActive = true
        
        bottomConstraint = NSLayoutConstraint(
            item: contentView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: imageContainerView,
            attribute: .bottom,
            multiplier: 1,
            constant: padding
        )
        bottomConstraint?.isActive = true
    }
    
}
