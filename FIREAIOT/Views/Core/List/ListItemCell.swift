//
//  ListItemCell.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 25/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

class ListItemCell: UITableViewCell {
    var listItem: ListItem! {
        didSet {
            update()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        update()
    }
    
    func update() {
        self.textLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        self.imageView?.image = #imageLiteral(resourceName: "checkmark")
        self.textLabel?.text = listItem.text
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.textLabel?.numberOfLines = 0
    }
}
