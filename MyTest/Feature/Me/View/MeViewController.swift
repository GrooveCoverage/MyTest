//
//  MeViewController.swift
//  MyTest
//
//  Created by GC on 2019/10/30.
//  Copyright © 2019 nsf. All rights reserved.
//

import UIKit

class MeViewController: BaseTableViewController {
      override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.setNavigationBarHidden(true, animated: true)
       }
}
