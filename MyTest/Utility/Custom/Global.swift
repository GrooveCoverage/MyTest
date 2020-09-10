//
//  Global.swift
//  MyTest
//
//  Created by GC on 2019/10/27.
//  Copyright © 2019 nsf. All rights reserved.
//  全局调用

import UIKit
import KeychainAccess

class Global {
    static let shared = Global()
    let appName: String = {
        let info = Bundle.main.infoDictionary
        let appName = info!["CFBundleDisplayName"]! as! String
        return appName
    }()
    let appVersion: String = {
         let info = Bundle.main.infoDictionary
         let version = info!["CFBundleShortVersionString"]! as! String
         return version
    }()
}

//alert
extension Global {
    static func alert(title: String?, msg: String?, inVC: UIViewController?, actionTitle: String = "确定", action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: actionTitle, style: .default, handler: action)
        alert.addAction(confirmAction)
        inVC?.present(alert, animated: true, completion: nil)
    }
    
    static func alert(title: String?, msg: String?, inVC: UIViewController?, confirmActionTitle: String = "确定", confirmAction: ((UIAlertAction) -> Void)?, cancelActionTitle: String = "取消", cancelAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmActionTitle, style: .default, handler: confirmAction)
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default, handler: cancelAction)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        inVC?.present(alert, animated: true, completion: nil)
    }
    
    static func callPhone(_ tel: String) {
        guard let url = URL(string: "tel://\(tel)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

extension Global {
    static func stringByX(str:String,startIndex:Int,endIndex:Int) -> String{
        //开始字符索引
        guard !str.isEmpty else {
            return ""
        }
        let endOffset = str.count > endIndex ? endIndex : str.count
        let start = str.index(str.startIndex, offsetBy: startIndex)
        //结束字符索引
        let end = str.index(str.startIndex, offsetBy: endOffset)
        let range = start..<end
        var s = String()
        for _ in 0..<endOffset - startIndex {
            s += "*"
        }
        return str.replacingCharacters(in: range, with: s)
    }
    
    
    static func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, expression: String) -> Bool {
        if string.containsEmoji { return false }
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if newString.isEmpty {
            return true
        }
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        return numberOfMatches != 0
    }
}

//界面跳转
extension Global {
    func pushViewController(_ vc: UIViewController, inTabbarIndex index: Int) {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        let oldNavC = rootVC?.selectedViewController as? BaseNavigationController
        _ = oldNavC?.popToRootViewController(animated: false)
        rootVC?.selectedIndex = index
        let newNavC = rootVC?.selectedViewController as? BaseNavigationController
        newNavC?.pushViewController(vc, animated: false)
    }
    
    func swapTabbarIndex(_ index: Int) {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as? BaseTabBarController
        let oldNavC = rootVC?.selectedViewController as? BaseNavigationController
        _ = oldNavC?.popToRootViewController(animated: false)
        rootVC?.selectedIndex = index
    }
    
}

//钥匙串存储
extension Global {
    //把设备ID存到钥匙串
    struct KeyChainConstant {
        static let kDeviceID = "DeviceID"
    }
    func saveDeviceID() {
        let keyChain = Keychain()
        if keyChain[KeyChainConstant.kDeviceID] == nil {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "Unknow"
            do {
                try keyChain.set(deviceId, key: KeyChainConstant.kDeviceID)
            } catch  {
                print("存储设备id失败")
            }
        }
    }
    
    //从钥匙串中取出设备id
    func deviceID() -> String {
        let keyChain = Keychain()
        let deviceID = keyChain[KeyChainConstant.kDeviceID] ?? "Unknow"
        return deviceID
    }
}

//时间戳转换
extension Global {
//    enum DateFormatType: String {
//        case yyyyMMdd = "yyyy-MM-dd"
//        case yyyyMMDDHHmm = "yyyy-MM-dd HH:mm"
//        case yyyyMMDDHHmmss = "yyyy-MM-dd HH:mm:ss"
//        case MMDD = "MM月dd日"
//        case MMddHHmm = "MM-dd HH:mm"
//        case MMDotdd = "MM.dd"
//        case HHmm = "HH:mm"
//        case MMHyphenDD = "MM-dd"
//    }
    
    func millisecondFromNow(by num: Int, isDay: Bool = true) -> TimeInterval {
        if isDay {
            return (Date().timeIntervalSince1970 + Double(num) * 24 * 60 * 60) * 1000
        }
       return (Date().timeIntervalSince1970 + Double(num) * 60 * 60) * 1000
    }
    
    func currentDayTimeInterval(from hour: Int, minute: Int) -> TimeInterval {
        var greCalendar = Calendar(identifier: .gregorian)
        greCalendar.timeZone = TimeZone(identifier: "Asia/Shanghai")!
        let dateComponents = greCalendar.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day], from: Date())
        var dateComponentsForDate = DateComponents()
        dateComponentsForDate.day = dateComponents.day
        dateComponentsForDate.month = dateComponents.month
        dateComponentsForDate.year = dateComponents.year
        dateComponentsForDate.hour = hour
        dateComponentsForDate.minute = minute
        let dateFromDateComponentsForDate = greCalendar.date(from: dateComponentsForDate)
        return dateFromDateComponentsForDate!.timeIntervalSince1970
    }
    
    func string(from timeInterval: TimeInterval, dateFormat: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
        let dateTimeInterval = Date(timeIntervalSince1970: timeInterval / 1000.0)
        let dateLiteral = formatter.string(from: dateTimeInterval)
        return dateLiteral
    }
    
    
    func string(from date: Date, dateFormat: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
        let dateLiteral = formatter.string(from: date)
        return dateLiteral
    }
    
    func string(from timeInterval: TimeInterval) -> (String, Bool) {
        let nowInterval = Date().timeIntervalSince1970
        let minus = Int64((timeInterval / 1000.0 - nowInterval))
        let oneDaySecond: Int64 = 24 * 60 * 60
        let day = minus / oneDaySecond
        if day == 1 {
            return ("仅1天", true)
        }
        else if day > 1 {
            return ("\(day)天", false)
        } else if minus > 0 {
            let hour = minus / (60 * 60)
            let minute = minus % (60 * 60) / 60
            if hour == 0 {
                if minute == 0 {
                    return ("1分", true)
                }
                return ("\(minute)分", true)
            }
            return ("\(hour)小时\(minute)分", true)
        } else {
            return ("已截止", false)
        }
    }
    
    
    func string(from timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval / 1000.0)
        if Calendar.current.isDateInToday(date) {
            return string(from: timeInterval, dateFormat: "HH:mm")
        }
        else if Calendar.current.isDateInYesterday(date) {
            return "昨天"
        } else {
            return string(from: timeInterval, dateFormat: "MM-dd")
        }
    }
}
