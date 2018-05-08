//
//  Label.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 27/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class Label: UILabel, Frameable {
    var height: CGFloat = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    convenience init(text: String, withFontSize size: CGFloat) {
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
