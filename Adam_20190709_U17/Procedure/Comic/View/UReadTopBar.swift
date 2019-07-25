//
//  UReadTopBar.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/24.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UReadTopBar: UIView {

    lazy var backButton: UIButton = {
        let name = UIButton(type: .custom)
        name.setImage(UIImage(named: "nav_back_black"), for: .normal)
        return name
    }()
    
    lazy var titleLabel: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.textColor = UIColor.black
        name.font = UIFont.boldSystemFont(ofSize: 18)
        
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI() {
        addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50))
        }
    }
}
