//
//  UReadBottomBar.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/24.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit
import SnapKitExtend

class UReadBottomBar: UIView {

    lazy var menuSlider: UISlider = {
        let name = UISlider()
        name.thumbTintColor = UIColor.theme
        name.minimumTrackTintColor = UIColor.theme
        name.isContinuous = false
        return name
    }()
    
    lazy var deviceDirectionButton: UIButton = {
        let name = UIButton(type: .system)
        name.setImage(UIImage(named: "readerMenu_changeScreen_horizontal")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return name
    }()
    
    lazy var lightButton: UIButton = {
        let name = UIButton(type: .system)
        name.setImage(UIImage(named: "readerMenu_luminance")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return name
    }()
    
    lazy var chapterButton: UIButton = {
        let name = UIButton(type: .system)
        name.setImage(UIImage(named: "readerMenu_catalog"), for: .normal)
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        addSubview(menuSlider)
        menuSlider.snp.makeConstraints {
            $0.left.right.top.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40))
            $0.height.equalTo(30)
        }
        
        addSubview(deviceDirectionButton)
        addSubview(lightButton)
        addSubview(chapterButton)
        
        let buttonArray = [deviceDirectionButton, lightButton, chapterButton]
        buttonArray.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 60, leadSpacing: 40, tailSpacing: 40)
        buttonArray.snp.makeConstraints {
            $0.top.equalTo(menuSlider.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
    }

}
