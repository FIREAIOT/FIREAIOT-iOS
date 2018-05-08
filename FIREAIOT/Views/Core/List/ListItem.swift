//
//  ListItem.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 25/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import Foundation

class ListItem {
    var indicator: ListItemIndicator = .checkmark
    var text: String = ""
    
    init(indicator: ListItemIndicator, text: String) {
        self.indicator = indicator
        self.text = text
    }
}
