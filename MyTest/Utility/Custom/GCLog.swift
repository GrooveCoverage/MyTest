//
//  GCLog.swift
//  MyTest
//
//  Created by GC on 2019/10/22.
//  Copyright © 2019 nsf. All rights reserved.
// 

import Foundation

public func GCLog<T>(_ message:T,
                file:String = #file,
                funcName:String = #function,
                lineNum:Int = #line){
    #if DEBUG
        let file = (file as NSString).lastPathComponent
        print("\(file)文件中\(funcName)方法\(lineNum)行：\(message)")
    #endif
}
