//
//  URankTCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/11.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class URankTCell: HYBaseTableViewCell {
    lazy var iconView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = UIView.ContentMode.scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 18)
        tl.textColor = UIColor.black
        return tl
    }()
    
    lazy var descLabel: UILabel = {
        let dl = UILabel()
        dl.font = UIFont.systemFont(ofSize: 14)
        dl.numberOfLines = 0
        dl.textColor = UIColor.gray
        return dl
    }()
    
    override func configUI() {
        let line = UIView().then{
            $0.backgroundColor = UIColor.background
        }
        contentView.addSubview(line)
        line.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(10)
            $0.bottom.equalTo(line.snp.top).offset(-10)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            $0.top.equalTo(iconView).offset(20)
        }

        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.bottom.equalTo(iconView)
        }
    }
    
    var model: RankingModel? {
        didSet {
            guard let model = model else {
                return
            }
            iconView.kf.setImage(urlString: model.cover)
            titleLabel.text = "\(model.title ?? "")榜"
            descLabel.text = model.subTitle
        }
    }
    
}
