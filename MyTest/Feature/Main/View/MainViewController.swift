//
//  MainViewController.swift
//  MyTest
//
//  Created by GC on 2019/10/25.
//  Copyright © 2019 nsf. All rights reserved.
//

import UIKit

class MainViewController: BaseTableViewController {
    
    deinit {
        GCLog("main vc deinit")
    }
    
    override func addPullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.stopPullToRefresh()
//            self?.showNavgationBar()
            GCLog("header stop")
        }
    }
    
    override func addInfiniteScrolling() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.stopLoadingMore()
            self?.noticeNoMoreData()
            GCLog("footer stop")
        }
    }
    
}


extension MainViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainViewController = MainViewController()
        navigationController?.pushViewController(mainViewController, animated: true)
    }
}
