//
//  UINavigationBar.swift
//  ManDoPick
//
//  Created by Saleem on 18/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

extension UINavigationBar{
    func gradient(colors : [UIColor]) {
        let navigationBarFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 2)
        let gradient = CAGradientLayer()
        
        gradient.frame = navigationBarFrame
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.startPoint = CGPoint(x: 1, y: 0)
        
        setBackgroundImage(image(fromLayer: gradient), for: .default)
    }
    
    func lightContent() {
        isTranslucent = false
        tintColor = .white
        barStyle = .black
        barTintColor = .white
    }
    
    private func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return outputImage!
    }
}
