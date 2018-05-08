//
//  BaseView.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 25/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class BaseView: UIView {
    // MARK: - lifeCicle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        self.setupTargets()
        self.setupUIConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit BaseView subclass")
    }
    
    // MARK: - custom
    open func setupTargets() {}
    open func setupUI() {}
    open func setupUIConstraints() {}
}
