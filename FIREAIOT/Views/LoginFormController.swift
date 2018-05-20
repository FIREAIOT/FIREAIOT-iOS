//
//  LoginFormController.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 28/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

protocol LoginFormControllerDelegate: class {
    func formSubmitted(email: String, password: String)
}

class LoginFormController: DatasourceController {
    // MARK: - properties
    private lazy var emailTextField = TextField(placeholder: "Email", with: #imageLiteral(resourceName: "email"), isEmail: true)
    private lazy var passwordTextField = TextField(placeholder: "Password", with: #imageLiteral(resourceName: "password"), isSecure: true)
    private lazy var submitButton = Button(title: "Login", type: .disabled)
    private lazy var createAccount: Button = {
        let button = Button(title: "")
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleColor = .gray
        
        let attruibutedText = NSMutableAttributedString(string: "Don’t have an account? ", attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.gray
            ])
        let signUpActionAttributedTex = NSMutableAttributedString(string: "Sign Up", attributes: [
            NSAttributedStringKey.foregroundColor : UIColor.primary
            ])
        attruibutedText.append(signUpActionAttributedTex)
        button.setAttributedTitle(attruibutedText, for: .normal)
        
        return button
    }()
    
    private lazy var sections: [Section] = [
        Section(
            items: [
                Spacer(),
                Label(text: "Account Information"),
                emailTextField, passwordTextField,
                Spacer()
            ]
        ),
        Section(
            items: [
                submitButton,
                createAccount
            ]
        )
    ]
    
    // MARK: - delegate
    weak var delegate: LoginFormControllerDelegate?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTargets()
        datasource = FormDatasource(sections: sections)
    }
    
    // MARK: - custom UI
    private func setupTargets(){
        submitButton.addTarget(self, action: #selector(submitButtonDidPressed(_:)), for: .touchUpInside)
        createAccount.addTarget(self, action: #selector(createAccountButtonDidPressed(_:)), for: .touchUpInside)
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc private func textFieldDidChanged() {
        if  (emailTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false)
            &&
            (passwordTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false) {
            submitButton.isEnabled = true
            submitButton.backgroundColor = .primary
        }else {
            submitButton.isEnabled = false
            submitButton.backgroundColor = .lightGray
        }
    }
    
    private func setupUI() {
        view.addSubview(createAccount)
        
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "town"))
//        imageView.contentMode = .bottomRight
//        collectionView?.backgroundView = imageView
        collectionView?.bounces = false
    }
    
    open override func collectionView(_ collectionView: UICollectionView,
                                      layout collectionViewLayout: UICollectionViewLayout,
                                      sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 50
        
        if let view = sections[indexPath.section].items[indexPath.row] as? Frameable {
            height = view.height
        }
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    @objc func submitButtonDidPressed(_ sender: UIButton) {
        view.endEditing(true)
        
        delegate?.formSubmitted(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @objc func createAccountButtonDidPressed(_ sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
