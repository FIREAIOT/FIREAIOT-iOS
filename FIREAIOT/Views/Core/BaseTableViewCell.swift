//
//  BaseTableViewCell.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 21/03/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func setupView() {}
    open func setupConstraints() {}
}
