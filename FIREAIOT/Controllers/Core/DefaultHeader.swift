//
//  DefaultHeader.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 20/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class DefaultHeader: DatasourceCell {
    override var datasourceItem: Any? {
        didSet {
            guard let title = datasourceItem as? String else { return }
            label.text = title
        }
    }
    
    let label = UILabel()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(label)
        
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
