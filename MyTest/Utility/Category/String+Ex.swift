//
//  String+Ex.swift
//  MyTest
//
//  Created by GC on 2019/10/27.
//  Copyright © 2019 nsf. All rights reserved.
//

import Foundation
import CommonCrypto

enum RegexValidate: String {
    case phone = "^1[0-9]\\d{9}$"
    case auth = "^[0-9]{6}$"
    case password = "^[A-Za-z0-9]{6,16}$"
    case integerFromOne = "^[1-9][0-9]*$"
    case integerLimitFive = "^[1-9][0-9]{0,4}$"
    case decimalLimitOne = "^[0-9]*((\\.)[0-9]{0,1})?$"
    case decimalLimitTwo = "^[0-9]*((\\.)[0-9]{0,2})?$"
    case spec = "^[^,-/]{0,10}$"
}

extension String {
    func substring(count: Int) -> String {
        let index = startIndex
        let endIndex = self.index(index, offsetBy: count)
        let range = index..<endIndex
        let text = self[range]
        return String(text)
    }
    
    func validate(_ validate: RegexValidate) -> Bool {
        let regex = NSPredicate(format: "SELF MATCHES %@", validate.rawValue)
        return regex.evaluate(with: self)
    }
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x278A,   //0x278b~0x2792为带圈的2到9，九宫格拼音会用到，所以排除
            0x2793...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
}

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        
        return String(format: hash as String)
    }
}
