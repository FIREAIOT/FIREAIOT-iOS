//
//  Colors.swift
//  ManDoPick
//
//  Created by Saleem Hadad on 06/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

extension UIColor {
    
    @nonobjc class var primary: UIColor {
        return UIColor(red: 3.0 / 255.0, green: 169.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var secondary: UIColor {
        return UIColor(red: 140.0 / 255.0, green: 219.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gray: UIColor {
        return UIColor(white: 155.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc open class var lightGray: UIColor {
        return UIColor(white: 225.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc open class var extraLightGray: UIColor {
        return UIColor(white: 248.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var success: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 220.0 / 255.0, blue: 94.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var info: UIColor {
        return UIColor(red: 84.0 / 255.0, green: 199.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warning: UIColor {
        return UIColor(red: 240.0 / 255.0, green: 81.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var primaryLowOpacity: UIColor {
        return UIColor(red: 116.0 / 255.0, green: 57.0 / 255.0, blue: 89.0 / 255.0, alpha: 0.1)
    }
    
    @nonobjc class func white(alpha: CGFloat) -> UIColor {
        return UIColor(white: 251.0 / 255.0, alpha: alpha)
    }
}
