//
//  UOtherWorksTCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/24.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UOtherWorksTCell: UBaseTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: DetailStaticModel? {
        didSet {
            guard let model = model else { return }
            textLabel?.text = "其他作品"
            detailTextLabel?.text = "\(model.otherWorks?.count ?? 0) 本"
            detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
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
