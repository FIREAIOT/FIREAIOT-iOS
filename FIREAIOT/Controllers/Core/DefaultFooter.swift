//
//  DefaultFooter.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 20/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class DefaultFooter: DefaultCell {
    override var datasourceItem: Any? {
        didSet {
            if datasourceItem == nil {
                label.text = "This is your default Footer"
            }
        }
    }
    
    let label = UILabel()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(label)
        
        label.text = "Footer Cell"
        label.anchor(
            top: topAnchor,
            right: rightAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            topConstant: 0,
            rightConstant: UIConstants.Edges.trailingMargin,
            bottomConstant: 0,
            leftConstant: UIConstants.Edges.leadingMargin
        )
    }
}
