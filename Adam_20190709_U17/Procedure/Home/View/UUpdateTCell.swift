//
//  UUpdateTCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/16.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UUpdateTCell: UBaseTableViewCell {
    
    private lazy var coverView: UIImageView = {
        let cv = UIImageView()
        cv.contentMode = ContentMode.scaleAspectFill
        cv.layer.cornerRadius = 5
        cv.layer.masksToBounds = true
        return cv
    }()
    
    private lazy var tipLabel: UILabel = {
        let cv = UILabel()
        cv.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cv.textColor = UIColor.white
        cv.font = UIFont.systemFont(ofSize: 9)
        return cv
    }()
    
    override func configUI() {
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
        }
        
        contentView.addSubview(tipLabel)
        tipLabel.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        let line = UIView().then{
            $0.backgroundColor = UIColor.background
        }
        
        contentView.addSubview(line)
        line.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model else {
                return
            }
            coverView.kf.setImage(urlString: model.cover)
            tipLabel.text = "   \(model.description ?? "")"
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
