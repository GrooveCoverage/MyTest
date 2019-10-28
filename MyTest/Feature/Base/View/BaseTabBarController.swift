//
//  BaseTabBarController.swift
//  MyTest
//
//  Created by GC on 2019/10/26.
//  Copyright © 2019 nsf. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        tabBar.barTintColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    private func configureViewControllers() {
        var children: [UIViewController] = []
        let viewControllers = [MainViewController()]
        let titles = ["首页", "商城", "发现", "我的"]
        let imageNames = ["tabbar_home", "tabbar_mall", "tabbar_find", "tabbar_my"]
        for i in 0..<viewControllers.count {
            let viewController = viewControllers[i]
            viewController.title = titles[i]
            viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.tabbarTextColor], for: .normal)
            viewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
            viewController.tabBarItem.image = UIImage(named: imageNames[i])?.withRenderingMode(.alwaysOriginal)
            viewController.tabBarItem.selectedImage = UIImage(named: imageNames[i] + "_highlighted")?.withRenderingMode(.alwaysOriginal)
            let navigationController = BaseNavigationController(rootViewController: viewControllers[i])
            children.append(navigationController)
        }
        self.viewControllers = children
    }
}
