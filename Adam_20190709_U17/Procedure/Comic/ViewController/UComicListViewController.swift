//
//  UComicListViewController.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/19.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

class UComicListViewController: HYBaseViewController {
    private var argCon: Int = 0
    private var argName: String?
    private var argValue: Int = 0
    private var page: Int = 1
    
    private var comicList = [ComicModel]()
    private var spinnerName: String?
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = UIColor.background
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: UComicTCell.self)
        tw.uHead = URefreshHeader { [weak self] in self?.loadData(more: false) }
        tw.uFoot = URefreshFooter { [weak self] in self?.loadData(more: true) }
        tw.uempty = UEmptyView { [weak self] in self?.loadData(more: false) }
        return tw
    }()
    
    convenience init(argCon: Int = 0, argName: String?, argValue: Int = 0) {
        self.init()
        self.argCon = argCon
        self.argName = argName
        self.argValue = argValue
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData(more: false)
    }
    
    @objc private func loadData(more: Bool) {
        page = (more ? (page + 1) : 1)
        ApiLoadingProvider.request(UApi.comicList(argCon: argCon, argName: argName ?? "", argValue: argValue, page: page), model: ComicListModel.self) { [weak self] (retutnData) in
            self?.tableView.uHead.endRefreshing()
            if retutnData?.hasMore == false {
                self?.tableView.uFoot.endRefreshingWithNoMoreData()
            } else {
                self?.tableView.uFoot.endRefreshing()
            }
            self?.tableView.uempty?.allowShow = true
            
            if !more {self?.comicList.removeAll() }
            self?.comicList.append(contentsOf: retutnData?.comics ?? [])
            self?.tableView.reloadData()
            
            guard let defaultParameters = retutnData?.defaultParameters else {
                return
            }
            self?.argCon = defaultParameters.defaultArgCon
            self?.spinnerName = defaultParameters.defaultConTagType
        }
    }
    
    override func configUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
    }

}

extension UComicListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UComicTCell.self)
        cell.spinnerName = spinnerName
        cell.indexPath = indexPath
        cell.model = comicList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = comicList[indexPath.row]
        let vc = UComicViewController(comicid: model.comicId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
