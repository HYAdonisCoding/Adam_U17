//
//  UCollectionViewSectionBackgroundLayoutLayout.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/9.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

private let SectionBackground = "UCollectionReusableView"

protocol UCollectionViewSectionBackgroundLayoutDelegateLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        backgroundColorForSectionAt section: Int) -> UIColor
}

extension UCollectionViewSectionBackgroundLayoutDelegateLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        backgroundForSectioinAt section: Int) -> UIColor {
        return collectionView.backgroundColor ?? UIColor.clear
    }
}

private class UCollectionViewLayoutAattributes: UICollectionViewLayoutAttributes {
    var backgroundColor = UIColor.white
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! UCollectionViewLayoutAattributes
        copy.backgroundColor = self.backgroundColor
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? UCollectionViewLayoutAattributes else {
            return false
        }
        
        if !self.backgroundColor.isEqual(rhs.backgroundColor) {
            return false
        }
        return super.isEqual(object)
    }
}

private class UCollectionReusabelView: UICollectionReusableView {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attr = layoutAttributes as? UCollectionViewLayoutAattributes else {
            return
        }
        
        self.backgroundColor = attr.backgroundColor
    }
}

class UCollectionViewSectionBackgroundLayout: UICollectionViewFlowLayout {
    
    private var decorationViewAattrs: [UICollectionViewLayoutAttributes] = []
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.register(UCollectionReusabelView.classForCoder(), forDecorationViewOfKind: SectionBackground)
    }
    
    override func prepare() {
        super.prepare()
        guard let numberOfSection = self.collectionView?.numberOfSections,
            let delegate = self.collectionView?.delegate as? UCollectionViewSectionBackgroundLayoutDelegateLayout
        else {
            return
        }
        
        self.decorationViewAattrs.removeAll()
        for section in 0..<numberOfSection {
            let indexPath = IndexPath(item: 0, section: section)
            
            guard let numberOfItems = collectionView?.numberOfItems(inSection: section),
                numberOfItems > 0,
                let firstItem = layoutAttributesForItem(at: indexPath),
                let lasstItem = layoutAttributesForItem(at: IndexPath(item: numberOfItems - 1, section: section)) else {
                continue
            }
            
            var inset = self.sectionInset
            if let delegateInset = delegate.collectionView?(self.collectionView!, layout: self, insetForSectionAt: section) {
                inset = delegateInset
            }
            
            var sectionFrame = firstItem.frame.union(lasstItem.frame)
            sectionFrame.origin.x = inset.left
            sectionFrame.origin.y -= inset.top
            
            let headLayout = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
            let footLayout = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath)
            
            if self.scrollDirection == .horizontal {
                sectionFrame.origin.y -= headLayout?.frame.height ?? 0
                sectionFrame.size.width += inset.left + inset.right
                sectionFrame.size.height = (collectionView?.frame.height ?? 0) + (headLayout?.frame.height ?? 0)
            } else {
                sectionFrame.origin.y -= headLayout?.frame.height ?? 0
                sectionFrame.size.width = collectionView?.frame.width ?? 0
                sectionFrame.size.height = sectionFrame.size.height + inset.top + inset.bottom + (headLayout?.frame.height ?? 0) + (footLayout?.frame.height ?? 0)
            }
            
            let attr = UCollectionViewLayoutAattributes(forDecorationViewOfKind: SectionBackground, with: IndexPath(item: 0, section: section))
            attr.frame = sectionFrame
            attr.zIndex = -1
            attr.backgroundColor = delegate.collectionView(self.collectionView!, layout: self, backgroundForSectioinAt: section)
            
            self.decorationViewAattrs.append(attr)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)
        attrs?.append(contentsOf: decorationViewAattrs.filter{
            return rect.intersects($0.frame)
        })
        return attrs
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == SectionBackground {
            return decorationViewAattrs[indexPath.section]
        }
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
}
