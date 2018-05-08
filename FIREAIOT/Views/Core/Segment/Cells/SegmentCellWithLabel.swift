//
//  SegmentCellWithLabel.swift
//  FIREAIOT
//
//  Created by Saleem on 24/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

final class SegmentCellWithLabel: SegmentCell {
    
    override func setupConstraintsForSubviews() {
        super.setupConstraintsForSubviews()
        
        guard let containerView = containerView else {
            return
        }
        
        let views = ["containerView": containerView]
        
        // main constraints
        
        let segmentTitleLabelHorizontConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-[containerView]-|",
            options: [.alignAllCenterX],
            metrics: nil,
            views: views
        )
        NSLayoutConstraint.activate(segmentTitleLabelHorizontConstraint)
        
        // custom constraints
        
        topConstraint = NSLayoutConstraint(
            item: containerView,
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
            toItem: containerView,
            attribute: .bottom,
            multiplier: 1,
            constant: padding
        )
        bottomConstraint?.isActive = true
    }

}
