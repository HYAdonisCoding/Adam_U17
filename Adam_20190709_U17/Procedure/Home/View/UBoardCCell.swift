//
//  UBoardCCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/16.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UBoardCCell: HYBaseCollectionViewCell {
    
    private lazy var iconView: UIImageView = {
        let cv = UIImageView()
        cv.contentMode = ContentMode.scaleAspectFill
        cv.layer.masksToBounds = true
        return cv
    }()
    
    private lazy var titleLabel: UILabel = {
        let cv = UILabel()
        cv.textColor = UIColor.black
        cv.font = UIFont.systemFont(ofSize: 14)
        cv.textAlignment = NSTextAlignment.center
        return cv
    }()
    
    override func configUI() {
        clipsToBounds = true
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(iconView.snp.bottom)
            $0.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            $0.height.equalTo(20)
        }
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model else {
                return
            }
            iconView.kf.setImage(urlString: model.cover)
            titleLabel.text = model.name;
        }
    }
    
}
