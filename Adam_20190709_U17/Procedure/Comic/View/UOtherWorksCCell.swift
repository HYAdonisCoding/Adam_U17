//
//  UOtherWorksCCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/24.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UOtherWorksCCell: UBaseCollectionViewCell {
    private lazy var iconView: UIImageView = {
        let name = UIImageView()
        name.contentMode = .scaleAspectFill
        name.clipsToBounds = true
        return name
    }()
    
    private lazy var titleLabel: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 14)
        return name
    }()
    
    private lazy var descLabel: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.gray
        name.font = UIFont.systemFont(ofSize: 12)
        return name
    }()
    
    override func configUI() {
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            $0.height.equalTo(25)
            $0.bottom.equalTo(descLabel.snp.top)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top)
        }
    }
    
    var model: OtherWorkModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.coverUrl, placeholder: (bounds.width > bounds.height) ? UIImage(named: "normal_placeholder_h") : UIImage(named: "normal_placeholder_v"))
            titleLabel.text = model.name
            descLabel.text = "更新至\(model.passChapterNum)话"
        }
    }
}

