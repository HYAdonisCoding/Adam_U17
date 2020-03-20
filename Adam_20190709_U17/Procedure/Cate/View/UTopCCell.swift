//
//  UTopCCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/25.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UTopCCell: UBaseCollectionViewCell {
    private lazy var iconView: UIImageView = {
        let name = UIImageView()
        name.contentMode = .scaleAspectFill
        return name
    }()
    
    override func configUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    var model: TopModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover)
        }
    }
}
