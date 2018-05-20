//
//  Form.swift
//  ManDoPick
//
//  Created by Saleem Hadad on 19/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

protocol RegisterFormControllerDelegate: class {
    func formSubmitted(name: String, email: String, password: String, mobile: String)
}

class ImageView: UIImageView, Frameable {
    var height: CGFloat = 150
}

class RegisterFormController: DatasourceController {
    // MARK: - properties
    private lazy var nameTextField = TextField(placeholder: "Name", with: #imageLiteral(resourceName: "person"))
    private lazy var emailTextField = TextField(placeholder: "Email", with: #imageLiteral(resourceName: "email"), isEmail: true)
    private lazy var passwordTextField = TextField(placeholder: "Password", with: #imageLiteral(resourceName: "password"), isSecure: true)
    private lazy var mobileTextField = TextField(placeholder: "Mobile", with: #imageLiteral(resourceName: "phone"), isPhone: true)
    
    private lazy var termsList = List(items: [
        ListItem(indicator: .checkmark, text: "By creating an account you agree to our Terms & Privacy Policy.")
    ])
    private lazy var submitButton = Button(title: "Create My Account", type: .disabled)
    
    private lazy var sections: [Section] = [
        Section(
            items: [
                Spacer(),
                Label(text: "Personal Information"),
                nameTextField, emailTextField, passwordTextField, mobileTextField,
                Spacer()
            ]
        ),
        Section(
            items: [
                Label(text: "Terms and Conditions"),
                termsList,
                Spacer()
            ]
        ),
        Section(
            items: [
                submitButton,
                Spacer()
            ]
        )
    ]
    
    // MARK: - delegate
    weak var delegate: RegisterFormControllerDelegate?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTargets()
        datasource = FormDatasource(sections: sections)
    }
    
    // MARK: - custom UI
    private func setupTargets() {
        submitButton.addTarget(self, action: #selector(submitButtonDidPressed(_:)), for: .touchUpInside)
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        mobileTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    private func setupUI() {
        mobileTextField.text = "+974"
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "town"))
        imageView.contentMode = .bottomRight
        collectionView?.backgroundView = imageView
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
    
    @objc private func textFieldDidChanged() {
        if  (nameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false)
            &&
            (emailTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false)
            &&
            (passwordTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false)
            &&
            (mobileTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false)
        {
            submitButton.isEnabled = true
            submitButton.backgroundColor = .primary
        }else {
            submitButton.isEnabled = false
            submitButton.backgroundColor = .lightGray
        }
    }
    
    @objc func submitButtonDidPressed(_ sender: UIButton) {
        view.endEditing(true)
        
        delegate?.formSubmitted(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, mobile: mobileTextField.text!)
    }
}


