//
//  URankCCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/25.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class URankCCell: UBaseCollectionViewCell {
    
    private lazy var iconView: UIImageView = {
        let name = UIImageView()
        name.contentMode = .scaleAspectFill
        return name
    }()

    private lazy var titleLabel: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 14)
        name.textColor = .black
        return name
    }()
    
    override func configUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(contentView.snp.width).multipliedBy(0.75)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(iconView.snp.bottom)
        }
    }
    
    var model: RankingModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover)
            titleLabel.text = model.sortName
        }
    }
}
