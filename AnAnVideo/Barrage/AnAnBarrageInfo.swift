//
//  AnAnBarrageInfo.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/10/8.
//

import UIKit

class AnAnBarrageInfo: NSObject {
//    弹幕内容
    var barrageBtn:AnAnBarrageBtn?
//    弹幕字体大小
    var barrageFont:UIFont?
//    弹幕之间时间间隔
    var timerMargin:TimeInterval?
//    弹幕并发条数
    var lineCount:Int = 0
//    弹幕id
    var barrageId:String?
//    时间戳
    var timePoint:TimeInterval?
//    弹幕内容
    var barrageContent:NSAttributedString?
//    弹幕文字颜色
    var barrageColor:String?
//    弹幕头像
    var barrageCover:String?
}
