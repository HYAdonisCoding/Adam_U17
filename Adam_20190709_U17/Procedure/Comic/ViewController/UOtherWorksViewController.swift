//
//  UOtherWorksViewController.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/24.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UOtherWorksViewController: UBaseViewController {
    
    var otherWorks: [OtherWorkModel]?
    
    private lazy var collectionView: UICollectionView = {
        let name = UICollectionViewFlowLayout()
        name.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        name.minimumInteritemSpacing = 5
        name.minimumLineSpacing = 10
        let cw = UICollectionView(frame: .zero, collectionViewLayout: name)
        cw.backgroundColor = UIColor.white
        cw.delegate = self
        cw.dataSource = self
        cw.register(cellType: UOtherWorksCCell.self)
        return cw
    }()
    
    convenience init(otherWorks: [OtherWorkModel]?) {
        self.init()
        self.otherWorks = otherWorks
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.title = "其他作品"
    }

}

extension UOtherWorksViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return otherWorks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.frame.width - 40) / 3)
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UOtherWorksCCell.self)
        cell.model = otherWorks?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let model = otherWorks?[indexPath.row] else { return }
        let vc = UComicViewController(comicid: model.comicId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
