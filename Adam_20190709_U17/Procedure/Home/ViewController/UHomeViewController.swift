//
//  UHomeViewController.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/11.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UHomeViewController: HYPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_search"), target: self, action: #selector(selectActiion))
    }
    
    @objc private func selectActiion() {
        navigationController?.pushViewController(USearchViewController(), animated: true)
    }
}
