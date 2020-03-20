//
//  UCateListViewController.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/11.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit
import MJRefresh

class UCateListViewController: UBaseViewController {
    
    private var searchString = ""
    private var topList = [TopModel]()
    private var rankList = [RankingModel]()
    
    private lazy var seachButton: UIButton = {
        let name = UIButton(type: .system)
        name.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 30)
        name.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        name.layer.cornerRadius = 15
        name.setTitleColor(.white, for: .normal)
        name.setImage(UIImage(named: "nav_search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        name.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        name.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        name.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        return name
    }()
    
    private lazy var collectionView: UICollectionView = {
        let name = UICollectionViewFlowLayout()
        name.minimumInteritemSpacing = 10
        name.minimumLineSpacing = 10
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: name)
        cw.backgroundColor = .white
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceVertical = true
        cw.register(cellType: URankCCell.self)
        cw.register(cellType: UTopCCell.self)
        cw.uHead = URefreshHeader { [weak self] in self?.loadData() }
        cw.uempty = UEmptyView { [weak self] in self?.loadData() }
        return cw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    private func loadData() {
        ApiLoadingProvider.request(UApi.cateList, model: CateListModel.self) { (returnData) in
            self.collectionView.uempty?.allowShow = true
            
            self.searchString = returnData?.recommendSearch ?? ""
            self.topList = returnData?.topList ?? []
            self.rankList = returnData?.rankingList ?? []
            
            self.seachButton.setTitle(self.searchString, for: .normal)
            self.collectionView.reloadData()
            self.collectionView.uHead.endRefreshing()
        }
    }
    
    @objc private func searchAction() {
        navigationController?.pushViewController(USearchViewController(), animated: true)
    }
    
    override func configUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.usnp.edges)
        }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.titleView = seachButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
}

extension UCateListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return topList.prefix(3).count
        }
        return rankList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UTopCCell.self)
            cell.model = topList[indexPath.row]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: URankCCell.self)
        cell.model = rankList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: section == 0 ? 0 : 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(screenWidth - 40) / 3.0)
        return CGSize(width: width, height: (indexPath.section == 0 ? 55 : (width * 0.75 + 30)))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let model = topList[indexPath.row]
            var titles: [String] = []
            var vcs: [UIViewController] = []
            for tab in model.extra?.tabList ?? [] {
                guard let tabTitle = tab.tabTitle else { continue }
                titles.append(tabTitle)
                vcs.append(UComicListViewController(argCon: tab.argCon, argName: tab.argName, argValue: tab.argValue))
                let vc = UPageViewController(titles: titles, vcs: vcs, pageStyle: .topTabBar)
                vc.title = model.sortName
                navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.section == 1 {
            let model = rankList[indexPath.row]
            let vc = UComicListViewController(argCon: model.argCon, argName: model.argName, argValue: model.argValue)
            vc.title = model.sortName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
