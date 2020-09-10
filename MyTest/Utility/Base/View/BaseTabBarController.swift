//
//  BaseTabBarController.swift
//  MyTest
//
//  Created by GC on 2019/10/26.
//  Copyright © 2019 nsf. All rights reserved.
//

import UIKit

class BaseTabBarController: ESTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        tabBar.barTintColor = UIColor(named: "white")
        // Do any additional setup after loading the view.
    }
    
    private func configureViewControllers() {
        var children: [UIViewController] = []
        let viewControllers = [MainViewController(), CenterViewController(), MeViewController()]
        let titles = ["首页", "中心", "我的"]
        let imageNames = ["tabbar_home", "tabbar_middle", "tabbar_my"]
        for i in 0..<viewControllers.count {
            let viewController = viewControllers[i]
            let title = titles[i]
            viewController.title = title

            let navigationController = BaseNavigationController(rootViewController: viewController)
            if (i == 1) {
                navigationController.tabBarItem = ESTabBarItem(LottieAnimateContentView(),title: nil, image: nil, selectedImage: nil)
            } else {
                navigationController.tabBarItem = ESTabBarItem(LottieAnimateBasicContentView(),title: title, image: UIImage(named: imageNames[i]), selectedImage: UIImage(named: imageNames[i] + "_highlighted"))
            }
            
            children.append(navigationController)
        }
        self.viewControllers = children
    }
}
