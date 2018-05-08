//
//  RoundImageView.swift
//  FIREAIOT
//
//  Created by Saleem on 24/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import Foundation
import UIKit

class RoundImageView: UIImageView {
    
    override var bounds: CGRect {
        didSet {
            updateCornerRadiusValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateCornerRadiusValue()
    }
    
    fileprivate func updateCornerRadiusValue() {
        let cornerRadius = min(bounds.size.height, bounds.size.width) / 2
        layer.cornerRadius = cornerRadius
    }
    
}
