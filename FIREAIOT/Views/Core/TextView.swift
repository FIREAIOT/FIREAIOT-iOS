//
//  TextView.swift
//  FIREAIOT
//
//  Created by Saleem Hadad on 22/03/2018.
//  Copyright © 2018 Binary Torch. All rights reserved.
//

import UIKit

open class TextView: UITextView, Frameable, UITextViewDelegate {
    // MARK: - properties
    internal var height: CGFloat = UIConstants.TextFields.defaultHeight
    private var leftPadding: CGFloat = 15
    private var rightPadding: CGFloat = 15
    private lazy var charCounter: Label = {
        let label = Label(text: "0/\(threshold)")
        return label
    }()
    private var totalLeftTextPadding: CGFloat {
        get {
            return leftPadding * 2
        }
    }
    
    // MARK: - API
    var threshold: Int = 50
    var contentDidChanged: (()->())?
    
    // MARK: - life cycle
    public convenience init(placeholder: String) {
        self.init(frame: .zero)
        
        setupBorder()
        updateTintColor()
        
        delegate = self
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(charCounter)
        charCounter.font = UIFont.boldSystemFont(ofSize: 10)
        charCounter.frame = CGRect(x: frame.width - 50, y: frame.height - 30, width: 50, height: 30)
    }
    
    // MARK: - custom UI
    private func setupBorder() {
        self.layer.cornerRadius = UIConstants.Corners.radius
        self.layer.borderWidth = UIConstants.Borders.largeBorderWidth
    }
    
    private func updateTintColor() {
        var color: UIColor!
        
        if self.hasText {
            color = .secondary
        }else{
            color = .lightGray
        }
        
        self.layer.borderColor = color.cgColor
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        updateTintColor()
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        updateTintColor()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let text = textView.text else { return true }
        return text.count - range.length < threshold
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        charCounter.text = "\(textView.text.count)/\(threshold)"
        contentDidChanged?()
        updateTintColor()
    }
}
