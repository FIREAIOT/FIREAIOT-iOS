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
import NVActivityIndicatorView

class HomeViewController: UIViewController, Authorizable {
    // MARK: - prperties
    private let homeView = HomeView()
    
    // MARK: - lifecyvle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = homeView
        homeView.delegate = self
        
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

extension HomeViewController: HomeViewDelegate {
    func sendFireButtonDidPressedWith(latitude: String, longitude: String) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(type: .ballRotateChase))
        NVActivityIndicatorPresenter.sharedInstance.setMessage("Sending fire alarm..")
        
        FireAlarmController.shared.store(latitude: latitude, longitude: longitude) { (success) in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
            if(success) {
                self.presentPopupAlert(withTitle: "Alarm Received", message: "Thank you for your contribution, we will send an assistance as soon as possible!")
            }else {
                self.presentPopupAlert(withTitle: "Something went wrong!", message: "Please try again later!")
            }
        }
    }
}
