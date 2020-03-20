//
//  UCommentTCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/25.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UCommentTCell: HYBaseTableViewCell {
    lazy var iconView: UIImageView = {
        let name = UIImageView()
        name.contentMode = .scaleAspectFill
        name.layer.cornerRadius = 20
        name.layer.masksToBounds = true
        return name
    }()
    
    lazy var nickNameLabel: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.gray
        name.font = UIFont.systemFont(ofSize: 13)
        return name
    }()
    
    lazy var contentTextView: UITextView = {
        let name = UITextView()
        name.isUserInteractionEnabled = false
        name.font = UIFont.systemFont(ofSize: 13)
        name.textColor = UIColor.black
        return name
    }()
    
    override func configUI() {
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(10)
            $0.width.height.equalTo(40)
        }
        
        contentView.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(10)
            $0.top.equalTo(iconView)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(15)
        }
        
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.left.right.equalTo(nickNameLabel)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-10)
        }
    }
    
    var viewModel: UCommentViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            iconView.kf.setImage(urlString: viewModel.model?.face)
            nickNameLabel.text = viewModel.model?.nickname
            contentTextView.text = viewModel.model?.content_filter
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

class UCommentViewModel {
    var model: CommentModel?
    var height: CGFloat = 0
    
    convenience init(model: CommentModel) {
        self.init()
        self.model = model
        
        let tw = UITextView().then { $0.font = UIFont.systemFont(ofSize: 13) }
        tw.text = model.content_filter
        let height = tw.sizeThatFits(CGSize(width: screenWidth - 70, height: CGFloat.infinity)).height
        self.height = max(60, height + 45)
        
    }
    
    required init() {
        
    }
}
