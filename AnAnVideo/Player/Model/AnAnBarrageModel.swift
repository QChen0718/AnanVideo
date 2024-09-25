//
//  AnAnBarrageModel.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/25.
//

import UIKit

enum BarrageSetType {
    case BarrageSetTypeArea
    case BarrageSetTypeAlpha
    case BarrageSetTypeFont
    case BarrageSetTypeSpeed
}

class AnAnBarrageModel: NSObject {
    var setType:BarrageSetType?
    var setName:String?
    var value:Float = 0.0
    init(setType: BarrageSetType? = nil,setName: String? = nil, value: Float) {
        self.setType = setType
        self.setName = setName
        self.value = value
    }
}
