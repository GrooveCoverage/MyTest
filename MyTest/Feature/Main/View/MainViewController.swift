//
//  MainViewController.swift
//  MyTest
//
//  Created by GC on 2019/10/25.
//  Copyright © 2019 nsf. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 30))
        button.setTitle("ssss", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(a), for: .touchUpInside)
        view.addSubview(button)
        // Do any additional setup after loading the view.
    }
    
    @objc func a() {
        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
