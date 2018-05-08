//
//  Authorizable.swift
//  FIREAIOT
//
//  Created by Saleem on 18/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

protocol Authorizable {
    func authenticate()
}

extension Authorizable where Self: UIViewController {
    func authenticate() {
//        handleUserAuthentication()
        
//        handleMobilePhoneAuthorization()
    }
    
//    func handleUserAuthentication() {
//        guard Auth.shared.guest() else { return }
//
//        var viewController: UIViewController!
//
//        if App.shared.language == nil {
//            viewController = LaunchViewController()
//        }else {
//            viewController = LoginViewController()
//        }
//
//        present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
//    }
//
//    func handleMobilePhoneAuthorization() {
//        guard Auth.shared.check() && Auth.shared.currentUser()?.confirmed == false else { return }
//
//        present(UINavigationController(rootViewController: MobileVerificationViewController()), animated: true, completion: nil)
//    }
}
