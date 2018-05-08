//
//  SegmentOptions.swift
//  FIREAIOT
//
//  Created by Saleem on 24/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit

// MARK: - Item

public struct SegmentItem {
    
    public var title: String?
    public var image: UIImage?
    public var selectedImage: UIImage?
    public var badgeCount: Int?
    public var badgeColor: UIColor?

    public init(title: String?, image: UIImage?, selectedImage: UIImage? = nil) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage ?? image
    }
    
    public mutating func addBadge(_ count: Int, color: UIColor) {
        self.badgeCount = count
        self.badgeColor = color
    }
    
    public mutating func removeBadge() {
        self.badgeCount = nil
        self.badgeColor = nil
    }
    
}

// MARK: - Content view

public struct SegmentState {
    
    var backgroundColor: UIColor
    var titleFont: UIFont
    var titleTextColor: UIColor
    
    public init(
        backgroundColor: UIColor = .clear,
        titleFont: UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
        titleTextColor: UIColor = .black) {
        self.backgroundColor = backgroundColor
        self.titleFont = titleFont
        self.titleTextColor = titleTextColor
    }
    
}

// MARK: - Horizontal separator

public enum SegmentHorizontalSeparatorType {
    case none
    case top
    case bottom
    case topAndBottom
    
}

public struct SegmentHorizontalSeparatorOptions {
    
    var type: SegmentHorizontalSeparatorType
    var height: CGFloat
    var color: UIColor
    
    public init(type: SegmentHorizontalSeparatorType = .topAndBottom, height: CGFloat = 0.0, color: UIColor = .darkGray) {
        self.type = type
        self.height = height
        self.color = color
    }
    
}

// MARK: - Vertical separator

public struct SegmentVerticalSeparatorOptions {
    
    var ratio: CGFloat
    var color: UIColor
    
    public init(ratio: CGFloat = 1, color: UIColor = .clear) {
        self.ratio = ratio
        self.color = color
    }

}

// MARK: - Indicator

public enum SegmentIndicatorType {
    
    case top
    case bottom
    
}

public struct SegmentIndicatorOptions {
    
    var type: SegmentIndicatorType
    var ratio: CGFloat
    var height: CGFloat
    var color: UIColor
    
    public init(type: SegmentIndicatorType = .bottom, ratio: CGFloat = 1, height: CGFloat = 0, color: UIColor = .orange) {
        self.type = type
        self.ratio = ratio
        self.height = height
        self.color = color
    }
    
}

// MARK: - Control options

public enum SegmentStyle: String {
    
    case onlyLabel, onlyImage, imageOverLabel, imageUnderLabel, imageBeforeLabel, imageAfterLabel
    
    public static let allStyles = [
        onlyLabel,
        onlyImage,
        imageOverLabel,
        imageUnderLabel,
        imageBeforeLabel,
        imageAfterLabel
    ]
    
    public func isWithText() -> Bool {
        switch self {
        case .onlyLabel, .imageOverLabel, .imageUnderLabel, .imageBeforeLabel, .imageAfterLabel:
            return true
        default:
            return false
        }
    }
    
    public func isWithImage() -> Bool {
        switch self {
        case .imageOverLabel, .imageUnderLabel, .imageBeforeLabel, .imageAfterLabel, .onlyImage:
            return true
        default:
            return false
        }
    }
}

public typealias SegmentStates = (defaultState: SegmentState, selectedState: SegmentState, highlightedState: SegmentState)

public struct SegmentOptions {
    
    var backgroundColor: UIColor
    var maxVisibleItems: Int
    var scrollEnabled: Bool
    var horizontalSeparatorOptions: SegmentHorizontalSeparatorOptions?
    var verticalSeparatorOptions: SegmentVerticalSeparatorOptions?
    var indicatorOptions: SegmentIndicatorOptions?
    var imageContentMode: UIViewContentMode
    var labelTextAlignment: NSTextAlignment
    var labelTextNumberOfLines: Int
    var states: SegmentStates
    var animationDuration: CFTimeInterval
    
    public init(backgroundColor: UIColor = .lightGray,
                maxVisibleItems: Int = 4,
                scrollEnabled: Bool = true,
                indicatorOptions: SegmentIndicatorOptions? = SegmentIndicatorOptions(),
                horizontalSeparatorOptions: SegmentHorizontalSeparatorOptions? = SegmentHorizontalSeparatorOptions(),
                verticalSeparatorOptions: SegmentVerticalSeparatorOptions? = SegmentVerticalSeparatorOptions(),
                imageContentMode: UIViewContentMode = .center,
                labelTextAlignment: NSTextAlignment = .center,
                labelTextNumberOfLines: Int = 0,
                segmentStates: SegmentStates = SegmentStates(defaultState: SegmentState(), selectedState: SegmentState(), highlightedState: SegmentState()),
                animationDuration: CFTimeInterval = 0.1) {
        self.backgroundColor = backgroundColor
        self.maxVisibleItems = maxVisibleItems
        self.scrollEnabled = scrollEnabled
        self.indicatorOptions = indicatorOptions
        self.horizontalSeparatorOptions = horizontalSeparatorOptions
        self.verticalSeparatorOptions = verticalSeparatorOptions
        self.imageContentMode = imageContentMode
        self.labelTextAlignment = labelTextAlignment
        self.labelTextNumberOfLines = labelTextNumberOfLines
        self.states = segmentStates
        self.animationDuration = animationDuration
    }
}
