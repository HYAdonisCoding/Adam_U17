//
//  UHairPowder.swift
//  Adam_20190705_U17
//
//  Created by Adonis_HongYang on 2019/7/5.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import Foundation
import UIKit

open class UHairPowder {
    public static let instance = UHairPowder()
    
    private class HairPowerView: UIView {
        static let cornerRadius: CGFloat = 40
        static let cornerY: CGFloat = 35
        override func draw(_ rect: CGRect) {
            let width = frame.width > frame.height ? frame.height : frame.width
            
            let rectPath = UIBezierPath()
            rectPath.move(to: CGPoint(x: 0, y: 0))
            rectPath.addLine(to: CGPoint(x: width, y: 0))
            rectPath.addLine(to: CGPoint(x: width, y: HairPowerView.cornerY))
            rectPath.addLine(to: CGPoint(x: 0, y: HairPowerView.cornerY))
            rectPath.close()
            rectPath.fill()
            
            let leftCornerPath = UIBezierPath()
            leftCornerPath.move(to: CGPoint(x: 0, y: HairPowerView.cornerY + HairPowerView.cornerRadius))
            leftCornerPath.addLine(to: CGPoint(x: 0, y: HairPowerView.cornerY))
            leftCornerPath.addLine(to: CGPoint(x: HairPowerView.cornerRadius, y: HairPowerView.cornerY))
            leftCornerPath.addQuadCurve(to: CGPoint(x: 0, y: HairPowerView.cornerY+HairPowerView.cornerRadius), controlPoint: CGPoint(x: 0, y: HairPowerView.cornerY))
            leftCornerPath.close()
            leftCornerPath.fill()
            
            let rightCornerPath = UIBezierPath()
            rightCornerPath.move(to: CGPoint(x: width, y: HairPowerView.cornerY+HairPowerView.cornerRadius))
            rightCornerPath.addLine(to: CGPoint(x: width, y: HairPowerView.cornerY))
            rightCornerPath.addLine(to: CGPoint(x: width-HairPowerView.cornerRadius, y: HairPowerView.cornerY))
            rightCornerPath.addQuadCurve(to: CGPoint(x: width, y: 35+HairPowerView.cornerRadius), controlPoint: CGPoint(x: width, y: HairPowerView.cornerY))
            rightCornerPath.close()
            rightCornerPath.fill()
        }
    }
    
    private var statusWindow: UIWindow = {
        let width = UIApplication.shared.keyWindow?.frame.width ?? 0
        let height = UIApplication.shared.keyWindow?.frame.height ?? 0
        
        let statusWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        statusWindow.windowLevel = UIWindow.Level.statusBar - 1
        
        let hairPowderView = HairPowerView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        hairPowderView.backgroundColor = UIColor.clear
        hairPowderView.clipsToBounds = true
        statusWindow.addSubview(hairPowderView)
        return statusWindow
    }()
    
    public func spread() {
        guard isIPhoneX else {
            return
        }
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        if #available(iOS 11.0, *) {
            if window.safeAreaInsets.top > 0.0 {
                DispatchQueue.main.async { [weak self] in
                    self?.statusWindow.makeKeyAndVisible()
                    DispatchQueue.main.async {
                        window.makeKey()
                    }
                }
            }
        }
    }
}
