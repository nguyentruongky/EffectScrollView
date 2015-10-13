//
//  AnimationScrollView.swift
//  EffectScrollView
//
//  Created by Ky Nguyen on 10/13/15.
//  Copyright © 2015 Ky Nguyen. All rights reserved.
//

import UIKit

class AnimationScrollView: UIScrollView {

    var effect = AnimationType.None
    
    var angleRatio: CGFloat = 0
    
    var rotationX: CGFloat = 0
    
    var rotationY: CGFloat = 0
    
    var rotationZ: CGFloat = 0
    
    var translateX: CGFloat = 0
    
    var translateY: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    func DEGREES_TO_RADIANS(angle: CGFloat) -> CGFloat {
        
        return (angle) / 180.0 * CGFloat(M_PI)
    }
    
    func RADIANS_TO_DEGREES(radians: CGFloat) -> CGFloat {
        
        return (radians) * (180.0 / CGFloat(M_PI))
    }
    
    func commonInit() {
        
        pagingEnabled = true
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func setEffect(effect: AnimationType) {
        
        self.effect = effect
        
        switch effect {
            
        case .Translation:
            self.angleRatio = 0.0
            
            self.rotationX = 0.0
            self.rotationY = 0.0
            self.rotationZ = 0.0
            
            self.translateX = 0.25
            self.translateY = 0.25
            break
        case .Depth:
            self.angleRatio = 0.5
            
            self.rotationX = -1.0
            self.rotationY = 0.0
            self.rotationZ = 0.0
            
            self.translateX = 0.25
            self.translateY = 0.0
            break
        case .Carousel:
            self.angleRatio = 0.5
            
            self.rotationX = -1.0
            self.rotationY = 0.0
            self.rotationZ = 0.0
            
            self.translateX = 0.25
            self.translateY = 0.25
            break
        case .Cards:
            self.angleRatio = 0.5
            
            self.rotationX = -1.0
            self.rotationY = -1.0
            self.rotationZ = 0.0
            
            self.translateX = 0.25
            self.translateY = 0.25
            break
        default:
            self.angleRatio = 0.0
            
            self.rotationX = 0.0
            self.rotationY = 0.0
            self.rotationZ = 0.0
            
            self.translateX = 0.0
            self.translateY = 0.0
            break
        }
        
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let contentOffsetX = self.contentOffset.x
//        let contentOffsetY = self.contentOffset.y
        
        for view in self.subviews {
            
            let t1: CATransform3D = view.layer.transform
            view.layer.transform = CATransform3DIdentity
            
            var distanceFromCenterX = view.frame.origin.x - contentOffsetX
//            var distanceFromCenterY = view.frame.origin.y - contentOffsetY
            
            view.layer.transform = t1
            
            distanceFromCenterX = distanceFromCenterX * 100.0 / CGRectGetWidth(self.frame)
            
            let angle = distanceFromCenterX * self.angleRatio
            
            let offset = distanceFromCenterX
            let translateX = (CGRectGetWidth(self.frame) * self.translateX) * offset / 100.0
            let translateY = (CGRectGetWidth(self.frame) * self.translateY) * abs(offset) / 100.0
            
            let t: CATransform3D = CATransform3DMakeTranslation(translateX, translateY, 0.0)
            
            view.layer.transform = CATransform3DRotate(t, DEGREES_TO_RADIANS(angle), self.rotationX, self.rotationY, self.rotationZ)
        }
    }
    
    func currentPage() -> Int {
        
        let pageWidth = self.frame.size.width
        let fractionalPage = self.contentOffset.x / pageWidth
        return lroundf(Float(fractionalPage))
    }

    func loadNextPage(animated: Bool) {
        
        loadPageIndex(self.currentPage() + 1, animated: animated)
    }
    
    
    func loadPreviousPage(animated: Bool) {
        
        loadPageIndex(self.currentPage() - 1, animated: animated)
    }

    func loadPageIndex(index: Int, animated: Bool) {
        
        var frame = self.frame
        frame.origin.x = frame.size.width * CGFloat(index)
        frame.origin.y = 0
        
        scrollRectToVisible(frame, animated: animated)
    }
    

}




enum AnimationType {
    
    case None
    case Translation
    case Depth
    case Carousel
    case Cards
}