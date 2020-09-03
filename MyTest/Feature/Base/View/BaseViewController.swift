//
//  BaseViewController.swift
//  MyTest
//
//  Created by GC on 2019/10/29.
//  Copyright © 2019 nsf. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewControllers()
        //查看ScrollingNavigationController的状态信息
//        configureScrollingNavBarDelegate()
    }
    
    private func configureViewControllers() {
        view.backgroundColor = UIColor(named: "white")
    }
}

extension BaseViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        GCLog("traitCollectionDidChange")
    }
}

#if DEBUG
extension BaseViewController: ScrollingNavigationControllerDelegate {
    func configureScrollingNavBarDelegate() {
        #if DEBUG
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.scrollingNavbarDelegate = self
        }
        #endif
    }
    
    func scrollingNavigationController(_ controller: ScrollingNavigationController, didChangeState state: NavigationBarState) {
        switch state {
        case .collapsed:
            GCLog("navbar collapsed")
        case .expanded:
            GCLog("navbar expanded")
        case .scrolling:
            GCLog("navbar is moving")
        }
    }
    
    func scrollingNavigationController(_ controller: ScrollingNavigationController, willChangeState state: NavigationBarState) {
        switch state {
        case .collapsed:
            GCLog("navbar will be collapsed")
        case .expanded:
            GCLog("navbar will be expanded")
        case .scrolling:
            GCLog("navbar will start move")
        }
    }
}
#endif
