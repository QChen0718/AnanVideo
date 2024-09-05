//
//  AnAnBaseModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/6.
//

import UIKit
import HandyJSON

struct AnAnBaseModel<T:Any>: HandyJSON {
    var code:String?
    var msg:String?
    var requestId:String?
    var data:T?
    var recordsTotal:String?
}
