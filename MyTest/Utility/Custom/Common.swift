//
//  Common.swift
//  MyTest
//
//  Created by GC on 2019/10/28.
//  Copyright © 2019 nsf. All rights reserved.
//  常用

import UIKit

//@_exported import SnapKit
//MARK: /*************颜色***************
struct Colors {
    static let backgroundColor = { () -> UIColor in
        let backgroundColor: UIColor
        if #available(iOS 13.0, *) {
           backgroundColor = UIColor { (trainCollection) -> UIColor in
                if trainCollection.userInterfaceStyle == .dark {
                    return UIColor.black
                } else {
                    return UIColor.white
                }
            }
        } else {
            backgroundColor = UIColor.white
        }
        return backgroundColor
    }()
    
    static let navigationBarColor = UIColor(hex: "ffffff")
    static let tabbarTextColor = UIColor(hex: "aaaaaa")
    static let tabbarTextHighlightColor = UIColor(hex: "009944")
    static let titleColor = UIColor(hex: "191919")
    static let textColor = UIColor(hex: "666666")
    static let subTextColor = UIColor(hex: "999999")
    static let color_009944 = UIColor(hex: "009944")
    static let white = UIColor(named: "white")
}

//MARK: /*************尺寸***************
struct MainScreen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let bounds = UIScreen.main.bounds
}

//MARK: /*************别名***************
typealias VoidHandle = () -> Void

//MARK: /*************自定义KEY***************

//MARK: /*************通知***************

//MARK: /*************第三方KEY***************

enum VendorKey: String {
    case UMAppKey = "1"
    case WXAppKey = "2"
    case WXAppSecret = "3"
    case QQAppID = "4"
    case QQAppKey = "5"
    case BaiduMapKey = "6"
}
