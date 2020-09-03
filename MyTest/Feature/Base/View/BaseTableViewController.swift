//
//  BaseTableViewController.swift
//  MyTest
//
//  Created by GC on 2020/9/3.
//  Copyright © 2020 nsf. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {
    final var isInitial = false
    static let navigtaionBarDelay = 50.0
    
    static let baseCellIdentifier = "baseCellIdentifier"
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.lightGray
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(BaseTableViewCell.classForCoder(), forCellReuseIdentifier: BaseTableViewController.baseCellIdentifier)
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.sectionHeaderHeight = 0.01
        tableView.sectionFooterHeight = 0.01
        
        let tableHeadView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.01))
        tableView.tableHeaderView = tableHeadView
        
        let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0.01))
        tableView.tableFooterView = tableFooterView
        
        view.addSubview(tableView)
        return tableView
    }()
    
    //MARK: **************生命周期*********************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(view)
        }
        
        tableView.es.addPullToRefresh {
            [weak self] in
            self?.addPullToRefresh()
        }

        tableView.es.addInfiniteScrolling { [weak self] in
            self?.addInfiniteScrolling()
        };
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let navigationController = navigationController as? ScrollingNavigationController {
           navigationController.shouldUpdateContentInset = false
            navigationController.followScrollView(tableView, delay: BaseTableViewController.navigtaionBarDelay)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !isInitial {
            isInitial = true
            let statusHeight = UIApplication.shared.statusBarFrame.height
            let navigationHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
            let topInset = self.navigationController?.navigationBar.isHidden == true ? view.safeAreaInsets.top : statusHeight + navigationHeight
            let bottomInset = view.safeAreaInsets.bottom
            tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: bottomInset, right: 0.0)
            tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: false)
            print("\(view.safeAreaInsets), \(tableView.adjustedContentInset)")
        }
    }
    
    //MARK: ***************PullToRefresh*******************
    func addPullToRefresh() {
        GCLog("请重写addPullToRefresh方法")
    }
    
    func stopPullToRefresh() {
        tableView.es.stopPullToRefresh()
    }
    
    func addInfiniteScrolling() {
        GCLog("请重写addInfiniteScrolling方法")
    }
    
    func stopLoadingMore() {
        tableView.es.stopLoadingMore()
    }
    
    func noticeNoMoreData() {
        tableView.es.noticeNoMoreData()
    }
}


//MARK: /*************ScrollingNavigationController***************
extension BaseTableViewController {
    func showNavgationBar() {
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar()
        }
    }
    
    func stopFollowingScrollView(_ showingNavbar: Bool = false) {
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView(showingNavbar: showingNavbar)
        }
    }
}

extension BaseTableViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewController.baseCellIdentifier, for: indexPath)
        return cell
    }
}
