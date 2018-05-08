//
//  Segment.swift
//  FIREAIOT
//
//  Created by Saleem on 24/12/17.
//  Copyright © 2017 Binary Torch. All rights reserved.
//

import UIKit
import QuartzCore

public typealias SegmentSelectionCallback = ((_ segmentio: Segment, _ selectedSegmentioIndex: Int) -> Void)

open class Segment: UIView, Frameable {
    var height: CGFloat = 140
    
    internal struct Points {
        var startPoint: CGPoint
        var endPoint: CGPoint
    }
    
    internal struct Context {
        var isFirstCell: Bool
        var isLastCell: Bool
        var isLastOrPrelastVisibleCell: Bool
        var isFirstOrSecondVisibleCell: Bool
        var isFirstIndex: Bool
    }
    
    internal struct ItemInSuperview {
        var collectionViewWidth: CGFloat
        var cellFrameInSuperview: CGRect
        var shapeLayerWidth: CGFloat
        var startX: CGFloat
        var endX: CGFloat
    }
    
    open var valueDidChange: SegmentSelectionCallback?
    open var selectedSegmentIndex = -1 {
        didSet {
            if selectedSegmentIndex != oldValue {
                reloadSegment()
                valueDidChange?(self, selectedSegmentIndex)
            }
        }
    }

    open fileprivate(set) var segmentItems = [SegmentItem]()
    fileprivate var segmentCollectionView: UICollectionView?
    fileprivate var segmentOptions = SegmentOptions()
    fileprivate var segmentStyle = SegmentStyle.imageOverLabel
    fileprivate var isPerformingScrollAnimation = false
    
    fileprivate var topSeparatorView: UIView?
    fileprivate var bottomSeparatorView: UIView?
    fileprivate var indicatorLayer: CAShapeLayer?
    fileprivate var selectedLayer: CAShapeLayer?
    
    // MARK: - Lifecycle
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        reloadSegment()
    }
    
    fileprivate func commonInit() {
        setupSegmentedCollectionView()
    }
    
    fileprivate func setupSegmentedCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(
            frame: frameForSegmentCollectionView(),
            collectionViewLayout: layout
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = true
        collectionView.isScrollEnabled = segmentOptions.scrollEnabled
        collectionView.backgroundColor = .clear
        collectionView.accessibilityIdentifier = "segment_collection_view"
        
        segmentCollectionView = collectionView
        
        if let segmentCollectionView = segmentCollectionView {
            addSubview(segmentCollectionView, options: .overlay)
        }
    }
    
    fileprivate func frameForSegmentCollectionView() -> CGRect {
        var separatorsHeight: CGFloat = 0
        var collectionViewFrameMinY: CGFloat = 0
        
        if let horizontalSeparatorOptions = segmentOptions.horizontalSeparatorOptions {
            let separatorHeight = horizontalSeparatorOptions.height
            
            switch horizontalSeparatorOptions.type {
            case .none:
                separatorsHeight = 0
            case .top:
                collectionViewFrameMinY = separatorHeight
                separatorsHeight = separatorHeight
            case .bottom:
                separatorsHeight = separatorHeight
            case .topAndBottom:
                collectionViewFrameMinY = separatorHeight
                separatorsHeight = separatorHeight * 2
            }
        }
        
        return CGRect(
            x: 0,
            y: collectionViewFrameMinY,
            width: bounds.width,
            height: bounds.height - separatorsHeight
        )
    }
    
    // MARK: - Setups:
    // MARK: Main setup
    
    open func setup(content: [SegmentItem], style: SegmentStyle, options: SegmentOptions?) {
        segmentItems = content
        segmentStyle = style
        
        selectedLayer?.removeFromSuperlayer()
        indicatorLayer?.removeFromSuperlayer()
        
        if let options = options {
            segmentOptions = options
            segmentCollectionView?.isScrollEnabled = segmentOptions.scrollEnabled
            backgroundColor = options.backgroundColor
        }
        
        if segmentOptions.states.selectedState.backgroundColor != .clear {
            selectedLayer = CAShapeLayer()
            if let selectedLayer = selectedLayer, let sublayer = segmentCollectionView?.layer {
                setupShapeLayer(
                    shapeLayer: selectedLayer,
                    backgroundColor: segmentOptions.states.selectedState.backgroundColor,
                    height: bounds.height,
                    sublayer: sublayer
                )
            }
        }
        
        if let indicatorOptions = segmentOptions.indicatorOptions {
            indicatorLayer = CAShapeLayer()
            if let indicatorLayer = indicatorLayer {
                setupShapeLayer(
                    shapeLayer: indicatorLayer,
                    backgroundColor: indicatorOptions.color,
                    height: indicatorOptions.height,
                    sublayer: layer
                )
            }
        }
        
        setupHorizontalSeparatorIfPossible()
        setupCellWithStyle(segmentStyle)
        segmentCollectionView?.reloadData()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setupHorizontalSeparatorIfPossible()
    }
    
    open func addBadge(at index: Int, count: Int, color: UIColor = .red) {
        segmentItems[index].addBadge(count, color: color)
        segmentCollectionView?.reloadData()
    }
    
    open func removeBadge(at index: Int) {
        segmentItems[index].removeBadge()
        segmentCollectionView?.reloadData()
    }
    
    // MARK: Collection view setup
    
    fileprivate func setupCellWithStyle(_ style: SegmentStyle) {
        var cellClass: SegmentCell.Type {
            switch style {
            case .onlyLabel:
                return SegmentCellWithLabel.self
            case .onlyImage:
                return SegmentCellWithImage.self
            case .imageOverLabel:
                return SegmentCellWithImageOverLabel.self
            case .imageUnderLabel:
                return SegmentCellWithImageUnderLabel.self
            case .imageBeforeLabel:
                return SegmentCellWithImageBeforeLabel.self
            case .imageAfterLabel:
                return SegmentCellWithImageAfterLabel.self
            }
        }
        
        segmentCollectionView?.register(
            cellClass,
            forCellWithReuseIdentifier: segmentStyle.rawValue
        )
        
        segmentCollectionView?.layoutIfNeeded()
    }
    
    // MARK: Horizontal separators setup
    
    fileprivate func setupHorizontalSeparatorIfPossible() {
        if superview != nil && segmentOptions.horizontalSeparatorOptions != nil {
            setupHorizontalSeparator()
        }
    }
    
    fileprivate func setupHorizontalSeparator() {
        topSeparatorView?.removeFromSuperview()
        bottomSeparatorView?.removeFromSuperview()
        
        guard let horizontalSeparatorOptions = segmentOptions.horizontalSeparatorOptions else {
            return
        }
        
        let height = horizontalSeparatorOptions.height
        let type = horizontalSeparatorOptions.type
        
        if type == .top || type == .topAndBottom {
            topSeparatorView = UIView(frame: CGRect.zero)
            setupConstraintsForSeparatorView(
                separatorView: topSeparatorView,
                originY: 0
            )
        }
        
        if type == .bottom || type == .topAndBottom {
            bottomSeparatorView = UIView(frame: CGRect.zero)
            setupConstraintsForSeparatorView(
                separatorView: bottomSeparatorView,
                originY: bounds.maxY - height
            )
        }
    }
    
    fileprivate func setupConstraintsForSeparatorView(separatorView: UIView?, originY: CGFloat) {
        guard let horizontalSeparatorOptions = segmentOptions.horizontalSeparatorOptions, let separatorView = separatorView else {
            return
        }
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = horizontalSeparatorOptions.color
        addSubview(separatorView)
        
        let topConstraint = NSLayoutConstraint(
            item: separatorView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: originY
        )
        topConstraint.isActive = true
        
        let leadingConstraint = NSLayoutConstraint(
            item: separatorView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(
            item: separatorView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )
        trailingConstraint.isActive = true
        
        let heightConstraint = NSLayoutConstraint(
            item: separatorView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: horizontalSeparatorOptions.height
        )
        heightConstraint.isActive = true
    }
    
    // MARK: CAShapeLayers setup

    fileprivate func setupShapeLayer(shapeLayer: CAShapeLayer, backgroundColor: UIColor, height: CGFloat, sublayer: CALayer) {
        shapeLayer.fillColor = backgroundColor.cgColor
        shapeLayer.strokeColor = backgroundColor.cgColor
        shapeLayer.lineWidth = height
        layer.insertSublayer(shapeLayer, below: sublayer)
    }
    
    // MARK: - Actions:
    // MARK: Reload segment
    public func reloadSegment() {
        segmentCollectionView?.collectionViewLayout.invalidateLayout()
        segmentCollectionView?.reloadData()
        scrollToItemAtContext()
        moveShapeLayerAtContext()
    }

    // MARK: Move shape layer to item
    
    fileprivate func moveShapeLayerAtContext() {
        if let indicatorLayer = indicatorLayer, let options = segmentOptions.indicatorOptions {
            let item = itemInSuperview(ratio: options.ratio)
            let context = contextForItem(item)
            
            let points = Points(
                context: context,
                item: item,
                pointY: indicatorPointY()
            )
            
            moveShapeLayer(
                indicatorLayer,
                startPoint: points.startPoint,
                endPoint: points.endPoint,
                animated: true
            )
        }
        
        if let selectedLayer = selectedLayer {
            let item = itemInSuperview()
            let context = contextForItem(item)
            
            let points = Points(
                context: context,
                item: item,
                pointY: bounds.midY
            )
            
            moveShapeLayer(
                selectedLayer,
                startPoint: points.startPoint,
                endPoint: points.endPoint,
                animated: true
            )
        }
    }
    
    // MARK: Scroll to item
    
    fileprivate func scrollToItemAtContext() {
        guard let numberOfSections = segmentCollectionView?.numberOfSections else {
            return
        }
        
        let item = itemInSuperview()
        let context = contextForItem(item)
        
        if context.isLastOrPrelastVisibleCell == true {
            let newIndex = selectedSegmentIndex + (context.isLastCell ? 0 : 1)
            let newIndexPath = IndexPath(item: newIndex, section: numberOfSections - 1)
            segmentCollectionView?.scrollToItem(
                at: newIndexPath,
                at: UICollectionViewScrollPosition(),
                animated: true
            )
        }
        
        if context.isFirstOrSecondVisibleCell == true && selectedSegmentIndex != -1 {
            let newIndex = selectedSegmentIndex - (context.isFirstIndex ? 1 : 0)
            let newIndexPath = IndexPath(item: newIndex, section: numberOfSections - 1)
            
            segmentCollectionView?.scrollToItem(
                at: newIndexPath,
                at: UICollectionViewScrollPosition(),
                animated: true
            )
        }
    }
    
    // MARK: Move shape layer
    
    fileprivate func moveShapeLayer(_ shapeLayer: CAShapeLayer, startPoint: CGPoint, endPoint: CGPoint, animated: Bool = false) {
        var endPointWithVerticalSeparator = endPoint
        let isLastItem = selectedSegmentIndex + 1 == segmentItems.count
        endPointWithVerticalSeparator.x = endPoint.x - (isLastItem ? 0 : 1)
        
        let shapeLayerPath = UIBezierPath()
        shapeLayerPath.move(to: startPoint)
        shapeLayerPath.addLine(to: endPointWithVerticalSeparator)
        
        if animated == true {
            isPerformingScrollAnimation = true
            isUserInteractionEnabled = false
            
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: "path")
            animation.fromValue = shapeLayer.path
            animation.toValue = shapeLayerPath.cgPath
            animation.duration = segmentOptions.animationDuration
            CATransaction.setCompletionBlock() {
                self.isPerformingScrollAnimation = false
                self.isUserInteractionEnabled = true
            }
            shapeLayer.add(animation, forKey: "path")
            CATransaction.commit()
        }
        
        shapeLayer.path = shapeLayerPath.cgPath
    }
    
    // MARK: - Context for item
    
    fileprivate func contextForItem(_ item: ItemInSuperview) -> Context {
        let cellFrame = item.cellFrameInSuperview
        let cellWidth = cellFrame.width
        let lastCellMinX = floor(item.collectionViewWidth - cellWidth)
        let minX = floor(cellFrame.minX)
        let maxX = floor(cellFrame.maxX)
        
        let isLastVisibleCell = maxX >= item.collectionViewWidth
        let isLastVisibleCellButOne = minX < lastCellMinX && maxX > lastCellMinX
        
        let isFirstVisibleCell = minX <= 0
        let isNextAfterFirstVisibleCell = minX < cellWidth && maxX > cellWidth
        
        return Context(
            isFirstCell: selectedSegmentIndex == 0,
            isLastCell: selectedSegmentIndex == segmentItems.count - 1,
            isLastOrPrelastVisibleCell: isLastVisibleCell || isLastVisibleCellButOne,
            isFirstOrSecondVisibleCell: isFirstVisibleCell || isNextAfterFirstVisibleCell,
            isFirstIndex: selectedSegmentIndex > 0
        )
    }
    
    // MARK: - Item in superview
    
    fileprivate func itemInSuperview(ratio: CGFloat = 1) -> ItemInSuperview {
        var collectionViewWidth: CGFloat = 0
        var cellWidth: CGFloat = 0
        var cellRect = CGRect.zero
        var shapeLayerWidth: CGFloat = 0
        
        if let collectionView = segmentCollectionView {
            collectionViewWidth = collectionView.frame.width
            let maxVisibleItems = segmentOptions.maxVisibleItems > segmentItems.count ? CGFloat(segmentItems.count) : CGFloat(segmentOptions.maxVisibleItems)
            cellWidth = floor(collectionViewWidth / maxVisibleItems)
            
            cellRect = CGRect(
                x: floor(CGFloat(selectedSegmentIndex) * cellWidth - collectionView.contentOffset.x),
                y: 0,
                width: floor(collectionViewWidth / maxVisibleItems),
                height: collectionView.frame.height
            )
            
            shapeLayerWidth = floor(cellWidth * ratio)
        }
        
        return ItemInSuperview(
            collectionViewWidth: collectionViewWidth,
            cellFrameInSuperview: cellRect,
            shapeLayerWidth: shapeLayerWidth,
            startX: floor(cellRect.midX - (shapeLayerWidth / 2)),
            endX: floor(cellRect.midX + (shapeLayerWidth / 2))
        )
    }
    
    // MARK: - Indicator point Y
    
    fileprivate func indicatorPointY() -> CGFloat {
        var indicatorPointY: CGFloat = 0
        
        guard let indicatorOptions = segmentOptions.indicatorOptions else {
            return indicatorPointY
        }
        
        switch indicatorOptions.type {
        case .top:
            indicatorPointY = (indicatorOptions.height / 2)
        case .bottom:
            indicatorPointY = frame.height - (indicatorOptions.height / 2)
        }
        
        guard let horizontalSeparatorOptions = segmentOptions.horizontalSeparatorOptions else {
            return indicatorPointY
        }
        
        let separatorHeight = horizontalSeparatorOptions.height
        let isIndicatorTop = indicatorOptions.type == .top
        
        switch horizontalSeparatorOptions.type {
        case .none:
            break
        case .top:
            indicatorPointY = isIndicatorTop ? indicatorPointY + separatorHeight : indicatorPointY
        case .bottom:
            indicatorPointY = isIndicatorTop ? indicatorPointY : indicatorPointY - separatorHeight
        case .topAndBottom:
            indicatorPointY = isIndicatorTop ? indicatorPointY + separatorHeight : indicatorPointY - separatorHeight
        }
        
        return indicatorPointY
    }
}

// MARK: - UICollectionViewDataSource

extension Segment: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: segmentStyle.rawValue,
            for: indexPath) as! SegmentCell
        
        let content = segmentItems[indexPath.row]
        
        cell.configure(
            content: content,
            style: segmentStyle,
            options: segmentOptions,
            isLastCell: indexPath.row == segmentItems.count - 1
        )
        
        cell.configure(
            selected: (indexPath.row == selectedSegmentIndex),
            selectedImage: content.selectedImage,
            image: content.image
        )
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension Segment: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSegmentIndex = indexPath.row
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension Segment: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxVisibleItems = segmentOptions.maxVisibleItems > segmentItems.count ? CGFloat(segmentItems.count) : CGFloat(segmentOptions.maxVisibleItems)
        return CGSize( width: floor(collectionView.frame.width / maxVisibleItems), height: collectionView.frame.height)
    }
    
}

// MARK: - UIScrollViewDelegate

extension Segment: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isPerformingScrollAnimation {
            return
        }
        
        if let options = segmentOptions.indicatorOptions, let indicatorLayer = indicatorLayer {
            let item = itemInSuperview(ratio: options.ratio)
            moveShapeLayer(
                indicatorLayer,
                startPoint: CGPoint(x: item.startX, y: indicatorPointY()),
                endPoint: CGPoint(x: item.endX, y: indicatorPointY()),
                animated: false
            )
        }
        
        if let selectedLayer = selectedLayer {
            let item = itemInSuperview()
            moveShapeLayer(
                selectedLayer,
                startPoint: CGPoint(x: item.startX, y: bounds.midY),
                endPoint: CGPoint(x: item.endX, y: bounds.midY),
                animated: false
            )
        }
    }
    
}

extension Segment.Points {
    
    init(context: Segment.Context, item: Segment.ItemInSuperview, pointY: CGFloat) {
        let cellWidth = item.cellFrameInSuperview.width
        
        var startX = item.startX
        var endX = item.endX
        
        if context.isFirstCell == false && context.isLastCell == false {
            if context.isLastOrPrelastVisibleCell == true {
                let updatedStartX = item.collectionViewWidth - (cellWidth * 2) + ((cellWidth - item.shapeLayerWidth) / 2)
                startX = updatedStartX
                let updatedEndX = updatedStartX + item.shapeLayerWidth
                endX = updatedEndX
            }
            
            if context.isFirstOrSecondVisibleCell == true {
                let updatedEndX = (cellWidth * 2) - ((cellWidth - item.shapeLayerWidth) / 2)
                endX = updatedEndX
                let updatedStartX = updatedEndX - item.shapeLayerWidth
                startX = updatedStartX
            }
        }
        
        if context.isFirstCell == true {
            startX = (cellWidth - item.shapeLayerWidth) / 2
            endX = startX + item.shapeLayerWidth
        }
        
        if context.isLastCell == true {
            startX = item.collectionViewWidth - cellWidth + (cellWidth - item.shapeLayerWidth) / 2
            endX = startX + item.shapeLayerWidth
        }
        
        startPoint = CGPoint(x: startX, y: pointY)
        endPoint = CGPoint(x: endX, y: pointY)
    }
    
}
