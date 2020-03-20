//
//  UReadCCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/24.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView: Placeholder {}

class UReadCCell: HYBaseCollectionViewCell {
    lazy var imageView: UIImageView = {
        let name = UIImageView()
        name.contentMode = .scaleAspectFit
        return name
    }()
    
    lazy var placeholder: UIImageView = {
        let name = UIImageView(image: UIImage(named: "yaofan"))
        name.contentMode = .center
        return name
    }()
    
    override func configUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints{ $0.edges.equalToSuperview() }
    }
    
    var model: ImageModel? {
        didSet {
            guard let model = model else { return }
            imageView.image = nil
            imageView.kf.setImage(urlString: model.location, placeholder: placeholder)
        }
    }
}
