//
//  UComicTCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/23.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UComicTCell: HYBaseTableViewCell {
    var spinnerName: String?
    
    lazy var iconView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
    }()
    
    lazy var titleLabel: UILabel = {
        let iw = UILabel()
        iw.textColor = UIColor.black
        return iw
    }()

    lazy var subTitleLabel: UILabel = {
        let iw = UILabel()
        iw.textColor = UIColor.gray
        iw.font = UIFont.systemFont(ofSize: 14)
        return iw
    }()
    
    lazy var descLabel: UILabel = {
        let iw = UILabel()
        iw.textColor = UIColor.gray
        iw.numberOfLines = 3
        iw.font = UIFont.systemFont(ofSize: 14)
        return iw
    }()

    lazy var tagLabel: UILabel = {
        let iw = UILabel()
        iw.textColor = UIColor.orange
        iw.font = UIFont.systemFont(ofSize: 14)
        return iw
    }()
    
    lazy var orderView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFit
        return iw
    }()

    override func configUI() {
        separatorInset = .zero
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints{
            $0.left.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0))
            $0.width.equalTo(100)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            $0.top.equalTo(iconView)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(60)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(orderView)
        orderView.snp.makeConstraints {
            $0.bottom.equalTo(iconView.snp.bottom)
            $0.right.equalToSuperview().offset(-10)
            $0.height.width.equalTo(30)
        }
        
        contentView.addSubview(tagLabel)
        tagLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.right.equalTo(orderView.snp.left).offset(-10)
            $0.height.equalTo(20)
            $0.bottom.equalTo(iconView.snp.bottom)
        }
    }
    var model: ComicModel? {
        didSet {
            guard let model = model else {
                return
            }
            iconView.kf.setImage(urlString: model.cover, placeholder: UIImage(named: "normal_placeholder_v"))
            
            titleLabel.text = model.name
            subTitleLabel.text = "\(model.tags?.joined(separator: " ") ?? "") | \(model.author ?? "")"
            descLabel.text = model.description
            
            if spinnerName == "更新时间" {
                let comicDate = Date().timeIntervalSince(Date(timeIntervalSince1970: TimeInterval(model.conTag)))
                var tagString = ""
                if comicDate < 60 {
                    tagString = "\(Int(comicDate))秒前"
                } else if comicDate < 3600 {
                    tagString = "\(Int(comicDate / 60))分前"
                } else if comicDate < 86400 {
                    tagString = "\(Int(comicDate / 3600))小时前"
                } else if comicDate < 31536000{
                    tagString = "\(Int(comicDate / 86400))天前"
                } else {
                    tagString = "\(Int(comicDate / 31536000))年前"
                }
                tagLabel.text = "\(spinnerName!) \(tagString)"
                orderView.isHidden = true
            } else {
                var tagString = ""
                if model.conTag > 100000000 {
                    tagString = String(format: "%.1f亿", Double(model.conTag) / 100000000)
                } else if model.conTag > 10000 {
                    tagString = String(format: "%.1f万", Double(model.conTag) / 10000)
                } else {
                    tagString = "\(model.conTag)"
                }
                if tagString != "0" { tagLabel.text = "\(spinnerName ?? "总点击") \(tagString)" }
                orderView.isHidden = false
            }

        }
    }
    
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else {
                return
            }
            if indexPath.row == 0 {
                orderView.image = UIImage.init(named: "rank_frist")
            } else if indexPath.row == 1 {
                orderView.image = UIImage.init(named: "rank_second")
            } else if indexPath.row == 2 {
                orderView.image = UIImage.init(named: "rank_third")
            } else {
                orderView.image = nil
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
