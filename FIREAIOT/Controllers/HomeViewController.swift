//
//  HomeViewController.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 02/05/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import UIKit
import GoogleMaps
import PopupDialog
import RevealingSplashView

class HomeViewController: UIViewController, Authorizable {
    // MARK: - prperties
    private let homeView = HomeView()
    
    // MARK: - lifecyvle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = homeView
        
        setupNavigationBar()
        
        showSplashScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.authenticate()
    }
    
    // MARK: - custom ui
    private func presentPopupAlert(withTitle title: String, message: String) {
        let popup = PopupDialog(title: title, message: message)
        let button = CancelButton(title: "Okay", action: nil)
        button.backgroundColor = .primary
        button.tintColor = .white
        button.titleColor = .white
        popup.addButton(button)
        self.present(popup, animated: true, completion: nil)
    }
    
    fileprivate func showSplashScreen() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let revealingSplashView = RevealingSplashView(iconImage: #imageLiteral(resourceName: "logo"), iconInitialSize: CGSize(width: 200, height: 200), backgroundColor: .white)
        window.addSubview(revealingSplashView)
        revealingSplashView.startAnimation() { }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "FIREAIOT"
        navigationController?.navigationBar.lightContent()
        navigationController?.navigationBar.gradient(colors: [.secondary, .primary])
    }
}
