//
//  HorizontalDevider.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 27/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class HorizontalDevider: UIView, Frameable {
    var height: CGFloat = 1
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 250, height: height)
        }  
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        
        self.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
