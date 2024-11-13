//
//  AnAnHotModel.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/12.
//

import UIKit
import HandyJSON

class AnAnHotModel: HandyJSON {
    required init() {
        
    }
    var newUserEnable:Bool = false
    var userRiskLevelName:String?
    var hotSearchBoo:Bool = false
    var userRiskLevel:String?
    var channelTagId:Int = 0
    var enabled:String?
    var channelTagName:String?
    var searchRecommendDtos:[AnanSearchRecommendDtos]?
    var newUserTopId:String?
    var hotRecommend:String?
    var orderNum:Int = 0
    var topId:String?
    var isSelect:Bool = false
}

struct AnanSearchRecommendDtos: HandyJSON {
               
    var label:String?
    var picUrl:String?
    var searchKeyword:String?
    var sortValue:String?
    var hotRecommendId:Int = 0
    var updateTime:Int = 0
    var title:String?
    var dramaId:String?
    var orderNum:Int = 0
    var createTime:Int = 0
    var score:String?
    var subtitle:String?
    var specialTagList:[String]?
    var id:Int = 0
}
