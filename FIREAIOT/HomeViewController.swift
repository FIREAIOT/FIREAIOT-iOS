//
//  HomeViewController.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 02/05/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import UIKit
import RevealingSplashView


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSplashScreen()
        
        title = "FIREAIOT"
        view.backgroundColor = .white
    }
    
    fileprivate func showSplashScreen() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let revealingSplashView = RevealingSplashView(iconImage: #imageLiteral(resourceName: "logo"), iconInitialSize: CGSize(width: 200, height: 200), backgroundColor: .white)
        window.addSubview(revealingSplashView)
        revealingSplashView.startAnimation() { }
    }
}

