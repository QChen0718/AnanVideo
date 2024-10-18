//
//  AnAnBarrageModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2024/10/1.
//

import UIKit
import HandyJSON

struct AnAnBarrageDataModel: HandyJSON {
    var p:String? //发送弹幕时间,id,颜色
    var e:String?
    var d:String? //发送弹幕内容
    var a:String? //弹幕选择的明星头像
}
