//
//  UIResponder+FirstResponder.swift
//  mutouwang
//
//  Created by GC on 17/7/7.
//  Copyright © 2017年 mutouw. All rights reserved.
//

import UIKit

private weak var currentResponder: AnyObject? = nil
extension UIResponder {
    class func currentFirstResponder() -> AnyObject? {
        currentResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder), to: nil, from: nil, for: nil)
        return currentResponder
    }
    
    @objc private func findFirstResponder() {
        currentResponder = self
    }
}
