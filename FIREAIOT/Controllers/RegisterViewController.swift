//
//  RegisterViewController.swift
//  ManDoPick
//
//  Created by Saleem Hadad on 11/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit
import PopupDialog
import NVActivityIndicatorView

class RegisterViewController: UIViewController {
    // MARK: - prperties
    internal let registerFormController = RegisterFormController()
    
    // MARK: - lifecyvle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerFormController.delegate = self
        self.present(viewController: registerFormController)
        self.setupNavigationBar()
    }
    
    deinit {
        print("deinti RegisterViewController")
    }
    
    // MARK: - custom ui
    func present(viewController: UIViewController) {
        addChildViewController(viewController)
        viewController.view.frame = self.view.bounds
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Sign Up"
        navigationController?.navigationBar.lightContent()
        navigationController?.navigationBar.gradient(colors: [.secondary, .primary])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension RegisterViewController: RegisterFormControllerDelegate {
    func formSubmitted(name: String, email: String, password: String, mobile: String) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(type: .ballRotateChase))
        NVActivityIndicatorPresenter.sharedInstance.setMessage("Crafting new account.. 🔮")
        
        Auth.shared.register(withName: name, email: email, password: password, mobile: mobile, callback: { [weak self] user, error in
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
        case .EmailAlreadyInUse:
            presentPopupAlert(withTitle: "Opps", message: "The email you entered already in use.")
        case .MobileAlreadyInUse:
            presentPopupAlert(withTitle: "Opps", message: "The mobile number already has been used.")
        case .InvalidMobile:
            presentPopupAlert(withTitle: "Opps", message: "The mobile number was invalid.")
        default:
            presentPopupAlert(withTitle: "Opps", message: "Something went wrong, please check you details.")
        }
    }
}
