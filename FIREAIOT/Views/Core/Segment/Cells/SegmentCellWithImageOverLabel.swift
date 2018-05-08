//
//  SegmentCellWithImageOverLabel.swift
//  FIREAIOT
//
//  Created by Saleem on 24/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class SegmentCellWithImageOverLabel: SegmentCell {
    
    override func setupConstraintsForSubviews() {
        super.setupConstraintsForSubviews()
        guard let imageContainerView = imageContainerView else {
            return
        }
        guard let containerView = containerView else {
            return
        }
        
        let metrics = ["labelHeight": segmentTitleLabelHeight]
        let views = [
            "imageContainerView": imageContainerView,
            "containerView": containerView
        ]
        
        // main constraints
        
        let segmentImageViewHorizontConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-[imageContainerView]-|",
            options: [],
            metrics: nil,
            views: views)
        NSLayoutConstraint.activate(segmentImageViewHorizontConstraint)
        
        let segmentTitleLabelHorizontConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "|-[containerView]-|",
            options: [.alignAllCenterX],
            metrics: nil,
            views: views
        )
        
       
        NSLayoutConstraint.activate(segmentTitleLabelHorizontConstraint)
        
        let contentViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[imageContainerView]-[containerView(labelHeight)]",
            options: [],
            metrics: metrics,
            views: views)
        NSLayoutConstraint.activate(contentViewVerticalConstraints)
        
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
            toItem: containerView,
            attribute: .bottom,
            multiplier: 1,
            constant: padding
        )
        bottomConstraint?.isActive = true
    }
    
}
