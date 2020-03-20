//
//  UTicketTCell.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/24.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UTicketTCell: UBaseTableViewCell {

    var model: DetailRealtimeModel? {
        didSet {
            guard let model = model else { return }
            let text = NSMutableAttributedString(string: "本月月票       |     累计月票  ",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
            text.append(NSAttributedString(string: "\(model.comic?.total_ticket ?? "")", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            text.insert(NSAttributedString(string: "\(model.comic?.monthly_ticket ?? "")", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]), at: 6)
            textLabel?.attributedText = text
            textLabel?.textAlignment = .center
            
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
