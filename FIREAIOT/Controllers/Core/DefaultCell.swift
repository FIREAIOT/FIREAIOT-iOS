//
//  DefaultCell.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 20/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class DefaultCell: DatasourceCell {
    override var datasourceItem: Any? {
        didSet {
            guard let view = datasourceItem as? UIView else { return }
            
            addSubview(view)
            view.anchor(
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
}
