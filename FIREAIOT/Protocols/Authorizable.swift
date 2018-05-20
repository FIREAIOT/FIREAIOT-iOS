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
        handleUserAuthentication()
    }
    
    func handleUserAuthentication() {
        guard Auth.shared.guest() else { return }

        present(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: nil)
    }
}
