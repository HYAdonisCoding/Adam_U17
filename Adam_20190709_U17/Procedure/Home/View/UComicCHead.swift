//
//  UComicCHead.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/11.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

typealias UComicCHeadMoreActionClosure = ()->Void

protocol UComicCHeadDelegate: class {
    func comicCHead(_ comicCHead: UComicCHead, moreAction button: UIButton)
}

class UComicCHead: UBaseCollectionReusableView {
    weak var delegate: UComicCHeadDelegate?
    
    private var moreActionClosure: UComicCHeadMoreActionClosure?
    
    lazy var iconView: UIImageView = {
        return UIImageView()
    }()
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.textColor = UIColor.black
        return tl
    }()
    
    lazy var moreButton: UIButton = {
        let mb = UIButton(type: .system)
        mb.setTitle("•••", for: .normal)
        mb.setTitleColor(UIColor.lightGray, for: .normal)
        mb.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        mb.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return mb
    }()
    
    @objc func moreAction(button: UIButton) {
        delegate?.comicCHead(self, moreAction: button)
        
        guard let closure = moreActionClosure else {
            return
        }
        closure()
    }
    
    func moreActionClosure(_ closure: UComicCHeadMoreActionClosure?) {
        moreActionClosure = closure
    }
    
    override func configUI() {
        addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(5)
            $0.centerY.height.equalTo(iconView)
            $0.width.equalTo(200)
        }
        
        addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
}
