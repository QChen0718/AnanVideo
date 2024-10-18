//
//  AnAnBarrageBtn.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/10/17.
//

import UIKit

class AnAnBarrageBtn: UIButton {

    var barrageInfo:AnAnBarrageInfo?
    class func createBarrageBtn()->AnAnBarrageBtn{
        let btn = AnAnBarrageBtn(type: .custom)
        return btn
    }

}
