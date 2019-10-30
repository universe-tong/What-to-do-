//
//  Todo.swift
//  Todos
//
//  Created by lwnlwn987 on 2019/9/19.
//  Copyright © 2019 刘伟楠. All rights reserved.
//

import Foundation
//class Todo{
//
//    var name = ""
//    var checked = false
//    init(<#parameters#>) {
//        <#statements#>
//    }
//}
//结构体struct约等于---class但是不需要构造函数初始化（init）
struct Todo:Codable{
    var name = ""
    var checked = false
}

