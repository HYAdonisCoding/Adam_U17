//
//  UComicCCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/11.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

enum UComicCCellStyle {
    case none
    case withTitle
    case withTitleAndDesc
}

class UComicCCell: UBaseCollectionViewCell {
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let iv = UILabel()
        iv.textColor = UIColor.black
        iv.font = UIFont.systemFont(ofSize: 14)
        return iv
    }()
    
    private lazy var descLabel: UILabel = {
        let iv = UILabel()
        iv.textColor = UIColor.gray
        iv.font = UIFont.systemFont(ofSize: 12)
        return iv
    }()
    
    override func configUI() {
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            $0.height.equalTo(25)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top)
        }
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    var style: UComicCCellStyle = .withTitle {
        didSet {
            switch style {
            case .none:
                titleLabel.snp.updateConstraints{
                    $0.bottom.equalToSuperview().offset(25)
                }
                titleLabel.isHidden = true
                descLabel.isHidden = true
            case .withTitle:
                titleLabel.snp.updateConstraints{
                    $0.bottom.equalToSuperview().offset(-10)
                }
                titleLabel.isHidden = false
                descLabel.isHidden = true
            case .withTitleAndDesc:
                titleLabel.snp.updateConstraints{
                    $0.bottom.equalToSuperview().offset(-25)
                }
                titleLabel.isHidden = false
                descLabel.isHidden = false
                
            }
        }
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model else {
                return
            }
            iconView.kf.setImage(urlString: model.cover, placeholder: (bounds.width > bounds.height) ? UIImage(named: "normal_placeholder_h") : UIImage(named: "normal_placeholder_v"))
            titleLabel.text = model.name ?? model.title
            descLabel.text = model.subTitle ?? "更新至\(model.content ?? "0")集"
        }
    }
    
}
