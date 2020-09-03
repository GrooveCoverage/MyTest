//
//  Stack.swift
//  MyTest
//
//  Created by GC on 2019/10/22.
//  Copyright © 2019 nsf. All rights reserved.
//

import Foundation

//栈
public struct Stack<Element> {
    fileprivate var array: [Element] = []
    var isEmpty: Bool {
        return array.isEmpty
    }
    var count: Int {
        return array.count
    }
    mutating func push(_ element: Element) {
        array.append(element)
    }
    mutating func pop() -> Element? {
        return array.popLast()
    }
    func peek() -> Element? {
        return array.last
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        let topDivider = "-----Stack---\n"
        let bottomDivider = "\n----------\n"
        let stackElements = array.map({"\($0)"}).reversed().joined(separator: "\n")
       return topDivider + stackElements + bottomDivider
    }
}
