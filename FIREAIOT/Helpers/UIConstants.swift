//
//  UIConstants.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 08/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import Foundation
import UIKit

struct UIConstants {
    struct Buttons {
        static let height: CGFloat = 44
        static let largHeight: CGFloat = 57
    }
    
    struct Borders {
        static let borderWidth: CGFloat = 1
        static let largeBorderWidth: CGFloat = 2
    }
    
    struct Corners {
        static let radius: CGFloat = 5
        static let largeRadius: CGFloat = 10
    }
    
    struct TextFields {
        static let defaultHeight: CGFloat = 40
        static let largeHeight: CGFloat = 50
        static let leftImageSize: CGSize = CGSize(width: 20, height: 20)
        static let leftPadding: CGFloat = 15
        static let rightPadding: CGFloat = -15
    }
    
    struct Edges {
        static let leadingMargin: CGFloat = 20
        static let trailingMargin: CGFloat = -20
    }
    
    struct Space {
        static let height: CGFloat = 10
    }
}
