//
//  UIScrollView+ParallaxHeader.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/10.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

/**
 A UIScrollView extension with a ParallaxHeader.
 */
extension UIScrollView {
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.parallaxHeader"
    }
    
    /// The parallax header.
    public var parallaxHeader: ParallaxHeader {
        get {
            if let header = objc_getAssociatedObject(self, &AssociatedKeys.descriptiveName) as? ParallaxHeader {
                return header
            }
            let header = ParallaxHeader()
            self.parallaxHeader = header
            return header
        }
        
        set(parallaxHeader) {
            parallaxHeader.scrollView = self
            objc_setAssociatedObject(self, &AssociatedKeys.descriptiveName, parallaxHeader, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
