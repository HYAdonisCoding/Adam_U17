//
//  UComicViewController.swift
//  Adam_20190709_U17
//
//  Created by Adonis_HongYang on 2019/7/23.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

import UIKit

protocol UComicViewWillEndDraggingDelegate: class {
    func comicWillEndDragging(_ scrollView: UIScrollView)
}

class UComicViewController: UBaseViewController {

    private var comicid: Int = 0
    
    private lazy var mainScrollView: UIScrollView = {
        let sw = UIScrollView()
        sw.delegate = self
        return sw
    }()
    
    private lazy var detailVC: UDetailViewController = {
        let dc = UDetailViewController()
        dc.delegate = self
        return dc
    }()
    
    private lazy var chapterVC: UChapterViewController = {
        let dc = UChapterViewController()
        dc.delegate = self
        return dc
    }()

    private lazy var navigationBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    
    private lazy var commentVC: UCommentViewController = {
        let dc = UCommentViewController()
        dc.delegate = self
        return dc
    }()
    
    private lazy var pageVC: UPageViewController = {
        let dc = UPageViewController(titles: ["详情", "目录", "评论"], vcs: [detailVC, chapterVC, commentVC], pageStyle: .topTabBar)
        return dc
    }()
    
    private lazy var headView: UComicCHead = {
        return UComicCHead(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarY + 150))
    }()
    
    private var detailStatic: DetailStaticModel?
    private var detailRealtime: DetailRealtimeModel?
    
    convenience init(comicid: Int) {
        self.init()
        self.comicid = comicid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .top
    }
    


}

extension UComicViewController: UIScrollViewDelegate, UComicViewWillEndDraggingDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -scrollView.parallaxHeader.minimumHeight {
            navigationController?.barStyle(.theme)
            navigationController?.title = detailStatic?.comic?.name
        } else {
            navigationController?.barStyle(.clear)
            navigationController?.title = ""
        }
    }
    func comicWillEndDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0, y: -self.mainScrollView.parallaxHeader.minimumHeight), animated: true)
        } else if scrollView.contentOffset.y < 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0, y: -self.mainScrollView.parallaxHeader.minimumHeight), animated: true)
        }
    }
    
    
}
