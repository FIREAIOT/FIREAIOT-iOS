//
//  Button.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 25/12/2017.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

open class Button: UIButton, Frameable {
    // MARK: - inits
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    public init(image: UIImage?, tintColor: UIColor = .blue) {
        super.init(frame: .zero)
        prepare(with: image, tintColor: tintColor)
        prepare()
    }
    
    public init(title: String?, titleColor: UIColor = .blue) {
        super.init(frame: .zero)
        prepare(with: title, titleColor: titleColor)
        prepare()
    }
    
    public init(title: String?, type: ButtonTypes, isEnabled: Bool = true) {
        super.init(frame: .zero)
        prepare(with: title, titleColor: .white)
        self.isEnabled = isEnabled
        if type == .success {
            backgroundColor = .success
        }else if type == .primary {
            backgroundColor = .primary
            self.isEnabled  = true
        }else if type == .disabled {
            backgroundColor = .lightGray
            self.isEnabled  = false
        }else if type == .info {
            backgroundColor = .gray
        }else if type == .warning {
            backgroundColor = .warning
        }else if type == .link {
            backgroundColor = .clear
            setTitleColor(.primary, for: .normal)
        }
        prepare()
    }
    
    // MARK: - properties
    var height: CGFloat = UIConstants.Buttons.height
    
    var type: ButtonTypes = .primary {
        didSet {
            if type == .success {
                backgroundColor = .success
            }else if type == .primary {
                backgroundColor = .primary
                self.isEnabled  = true
            }else if type == .disabled {
                backgroundColor = .lightGray
                self.isEnabled  = false
            }else if type == .info {
                backgroundColor = .gray
            }else if type == .warning {
                backgroundColor = .warning
            }else if type == .link {
                backgroundColor = .clear
                setTitleColor(.primary, for: .normal)
            }
        }
    }
    
    open override var backgroundColor: UIColor? {
        didSet {
            layer.backgroundColor = backgroundColor?.cgColor
        }
    }
    
    open var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
            setImage(image, for: .selected)
            setImage(image, for: .highlighted)
            setImage(image, for: .disabled)
            
            if #available(iOS 9, *) {
                setImage(image, for: .application)
                setImage(image, for: .focused)
                setImage(image, for: .reserved)
            }
        }
    }
    
    open var title: String? {
        didSet {
            setTitle(title, for: .normal)
            setTitle(title, for: .selected)
            setTitle(title, for: .highlighted)
            setTitle(title, for: .disabled)
            
            if #available(iOS 9, *) {
                setTitle(title, for: .application)
                setTitle(title, for: .focused)
                setTitle(title, for: .reserved)
            }
            
            guard nil != title else {
                return
            }
            
            guard nil == titleColor else {
                return
            }
            
            titleColor = .blue
        }
    }
    
    open var titleColor: UIColor? {
        didSet {
            setTitleColor(titleColor, for: .normal)
            setTitleColor(titleColor, for: .highlighted)
            setTitleColor(titleColor, for: .disabled)
            
            if nil == selectedTitleColor {
                setTitleColor(titleColor, for: .selected)
            }
            
            if #available(iOS 9, *) {
                setTitleColor(titleColor, for: .application)
                setTitleColor(titleColor, for: .focused)
                setTitleColor(titleColor, for: .reserved)
            }
        }
    }
    
    open var selectedTitleColor: UIColor? {
        didSet {
            setTitleColor(selectedTitleColor, for: .selected)
        }
    }
    
    open func prepare() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = UIConstants.Corners.radius
        layer.masksToBounds = true
    }
    
    fileprivate func prepare(with image: UIImage?, tintColor: UIColor) {
        self.image = image
        self.tintColor = tintColor
    }
    
    fileprivate func prepare(with title: String?, titleColor: UIColor) {
        self.title = title
        self.titleColor = titleColor
    }
}
