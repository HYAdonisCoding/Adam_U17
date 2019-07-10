//
//  UBaseTableViewCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/10.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit
import Reusable

class UBaseTableViewCell: UITableViewCell, Reusable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    open func configUI() {}
}
