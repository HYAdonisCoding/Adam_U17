//
//  USpecialTCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/16.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class USpecialTCell: HYBaseTableViewCell {

    lazy var coverView: UIImageView = {
        let tl = UIImageView()
        tl.contentMode = ContentMode.scaleAspectFill
        tl.layer.cornerRadius = 5
        tl.layer.masksToBounds = true
        return tl
    }()
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.black
        tl.font = UIFont.systemFont(ofSize: 14)
        return tl
    }()

    lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.black
        tl.font = UIFont.systemFont(ofSize: 14)
        return tl
    }()

    override func configUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.left.top.right.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            $0.height.equalTo(40)
        }
        
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints{
            $0.left.bottom.right.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
            $0.top.equalTo(40)
        }
        
        contentView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints{
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        let line = UIView().then {
            $0.backgroundColor = UIColor.background
        }
        
        contentView.addSubview(line)
        line.snp.makeConstraints{
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model else {
                return
            }
            titleLabel.text = model.title
            coverView.kf.setImage(urlString: model.cover)
            tipLabel.text = "    \(model.subTitle ?? "")"
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
