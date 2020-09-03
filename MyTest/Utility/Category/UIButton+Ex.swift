//
//  UIButton+Ex.swift
//  MyTest
//
//  Created by GC on 2019/10/27.
//  Copyright © 2019 nsf. All rights reserved.
//

import UIKit

enum ButtonImageTitleStyle: Int {
    case imagePositionLeft = 0                  //左图右字
    case imagePositionRight                     //右图左字
    case imagePositionTop                        //上图下字
    case imagePositionBottom                  //下图上字
}

extension UIButton {
    //圆角按钮
    static func cornerButton(title: String, titleColor: UIColor? = Colors.white, fontSize: CGFloat = 16, bgColor: UIColor? = Colors.color_009944, cornerRadius: CGFloat = 10) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
        button.backgroundColor = bgColor
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        return button
    }
    
    //设置图片文字排列位置
    func setButtonImageTitleStyle(_ style: ButtonImageTitleStyle, padding: CGFloat) {
        if (self.imageView?.image != nil) && (self.titleLabel?.text != nil) {
            self.titleEdgeInsets = .zero
            self.imageEdgeInsets = .zero
            let labelWidth = self.titleLabel!.intrinsicContentSize.width
            let labelHeight = self.titleLabel!.intrinsicContentSize.height
            let imageWidth = self.imageView!.intrinsicContentSize.width
            let imageHeight = self.imageView!.intrinsicContentSize.height
            let imageOffsetX = labelWidth / 2
            let imageOffsetY = imageHeight / 2 + padding / 2
            let labelOffsetX = imageWidth / 2
            let labelOffsetY = labelHeight / 2 + padding / 2
            switch (style) {
            case .imagePositionLeft:
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -padding / 2, bottom: 0, right: padding / 2)
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding / 2, bottom: 0, right: -padding / 2)
                self.contentEdgeInsets = UIEdgeInsets(top: 0, left: padding / 2, bottom: 0, right: padding / 2)
            case .imagePositionRight:
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + padding / 2, bottom: 0, right: -(labelWidth + padding / 2))
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - padding / 2, bottom: 0, right: imageWidth + padding / 2)
                self.contentEdgeInsets = UIEdgeInsets(top: 0, left: padding / 2, bottom: 0, right: padding / 2)
            case .imagePositionTop:
                let maxWidth = max(imageWidth, labelWidth)
                let maxHeight = max(imageHeight, labelHeight)
                let changeWidth = imageWidth + labelWidth - maxWidth
                let changeHeight = imageHeight + labelHeight + padding - maxHeight
                self.imageEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: imageOffsetX, bottom: labelOffsetY, right: -imageOffsetX)
                self.titleEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: -labelOffsetX, bottom: -imageOffsetY, right: labelOffsetX)
                self.contentEdgeInsets = UIEdgeInsets(top: changeHeight - labelOffsetY, left: -changeWidth / 2, bottom: labelOffsetY, right: -changeWidth / 2)
            case .imagePositionBottom:
                let maxWidth = max(imageWidth, labelWidth)
                let maxHeight = max(imageHeight, labelHeight)
                let changeWidth = imageWidth + labelWidth - maxWidth
                let changeHeight = imageHeight + labelHeight + padding - maxHeight
                self.imageEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: imageOffsetX, bottom: -labelOffsetY, right: -imageOffsetX)
                self.titleEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: -labelOffsetX, bottom: imageOffsetY, right: labelOffsetX)
                self.contentEdgeInsets = UIEdgeInsets(top: changeHeight - labelOffsetY, left: -changeWidth / 2, bottom: labelOffsetY, right: -changeWidth / 2)
            }
        }
    }
}
