//
//  TextField.swift
//  FIREAIOT
//
//  Created by Saleem on 24/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

@objc(TextFieldDelegate)
public protocol TextFieldDelegate: UITextFieldDelegate {
    @objc optional func didBeginEditing(textField: TextField)
    @objc optional func didEndEditing(textField: TextField)
}

open class TextField: UITextField, Frameable {
    // MARK: - properties
    private var leftPadding: CGFloat = 15
    private var rightPadding: CGFloat = 15
    internal var height: CGFloat = UIConstants.TextFields.defaultHeight
    
    private var imageSize = CGSize(width: 20, height: 20)
    private var totalLeftTextPadding: CGFloat {
        get {
            return (leftPadding * 2) + imageSize.width
        }
    }
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size = imageSize
        return imageView
    }()
    
    // MARK: - life cycle
    public convenience init(placeholder: String, with image: UIImage?, isSecure: Bool = false, isEmail: Bool = false, isPhone: Bool = false) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        
        if let image = image {
            self.leftImageView.image = image.withRenderingMode(.alwaysTemplate)
            self.leftView = leftImageView
            self.leftViewMode = .always
        }else {
            self.leftPadding = 0
            self.rightPadding = 0
            self.imageSize.width = 0
        }
        if isEmail {
            self.keyboardType = .emailAddress
        }
        if isPhone {
            self.keyboardType = .numberPad
        }
        
        self.setupBorder()
        self.updateTintColor()
        self.prepareTargetHandlers()
        
        self.isSecureTextEntry = isSecure
        self.clearButtonMode = .whileEditing
        self.autocorrectionType = .no
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - custom UI
    private func setupBorder() {
        self.layer.cornerRadius = UIConstants.Corners.radius
        self.layer.borderWidth = UIConstants.Borders.largeBorderWidth
    }
    
    private func updateTintColor() {
        var color: UIColor!
        
        if self.isEditing || self.hasText {
            color = .secondary
        }else{
            color = .lightGray
        }
        
        self.leftImageView.tintColor = color
        self.layer.borderColor = color.cgColor
    }
    
    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, totalLeftTextPadding, 0, rightPadding))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, totalLeftTextPadding, 0, rightPadding))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, totalLeftTextPadding, 0, rightPadding))
    }
    
    func prepareTargetHandlers() {
        addTarget(self, action: #selector(handleEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(handleEditingDidEnd), for: .editingDidEnd)
    }
}

fileprivate extension TextField {
    @objc func handleEditingDidBegin() {
        updateTintColor()

        (delegate as? TextFieldDelegate)?.didBeginEditing?(textField: self)
    }
    
    @objc func handleEditingDidEnd() {
        updateTintColor()
        
        (delegate as? TextFieldDelegate)?.didEndEditing?(textField: self)
    }
}
