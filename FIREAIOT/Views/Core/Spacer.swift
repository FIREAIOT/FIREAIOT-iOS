//
//  Spacer.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 27/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class Spacer: UIView, Frameable {
    var height: CGFloat = UIConstants.Space.height
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 1, height: height)
        }
    }
}
