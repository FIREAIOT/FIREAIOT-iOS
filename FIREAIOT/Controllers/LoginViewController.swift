//
//  LoginViewController.swift
//  ManDoPick
//
//  Created by Saleem Hadad on 28/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit
import PopupDialog
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    // MARK: - prperties
    internal let loginFormController = LoginFormController()
    
    // MARK: - lifecyvle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginFormController.delegate = self
        self.present(viewController: loginFormController)
        self.setupNavigationBar()
    }
    
    deinit {
        print("deinit LoginViewController")
    }
    
    // MARK: - custom ui
    func present(viewController: UIViewController) {
        addChildViewController(viewController)
        viewController.view.frame = self.view.bounds
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Login"
        navigationController?.navigationBar.lightContent()
        navigationController?.navigationBar.gradient(colors: [.secondary, .primary])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension LoginViewController: LoginFormControllerDelegate {
    func formSubmitted(email: String, password: String) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(type: .ballRotateChase))
        NVActivityIndicatorPresenter.sharedInstance.setMessage("Authorising..")
        
        Auth.shared.login(withEmail: email, password: password, callback: { [weak self] user, error in
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
            self?.handleRegistrationErrors(error: error)
        })
    }
    
    private func presentPopupAlert(withTitle title: String, message: String) {
        let popup = PopupDialog(title: title, message: message)
        let button = CancelButton(title: "Okay", action: nil)
        button.backgroundColor = .primary
        button.tintColor = .white
        button.titleColor = .white
        popup.addButton(button)
        self.present(popup, animated: true, completion: nil)
    }
    
    fileprivate func handleRegistrationErrors(error: AuthErrorCodes) {
        switch error {
        case .None:
            dismiss(animated: true, completion: nil)
        case .InvalidEmailOrPassword:
            presentPopupAlert(withTitle: "Opps", message: "Please check your email and password.")
        default:
            presentPopupAlert(withTitle: "Opps", message: "Something went wrong, please check you details.")
        }
    }
}


