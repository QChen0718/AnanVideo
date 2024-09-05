//
//  AnAnHomeModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/16.
//

import UIKit
import HandyJSON

struct AnAnHomeModel:HandyJSON{
    var isEnd:Bool = false
    var sections:[SectionModel]?
    var bean:String?
    var guessFavorite:String?
    var bannerTop:[BannerTopModel]?
    var top:String?
}

struct SectionModel:HandyJSON {
    var targetType:String?
    var sequence:Int?
    var resourceFlag:Int?
    var endTime:String?
    var moreText:String?
    var sectionType:String?
    var position:Int?
    var displayTitle:String?
    var id:String?
    var moreTarget:String?
    var riskLevel:String?
    var startTime:String?
    var name:String?
    var display:String?
    var targetId:String?
    var sectionContents:[SectionContentModel]?
    var bannerTop:[BannerTopModel]?
}

struct SectionContentModel:HandyJSON{
    var orderNum:Int?
    var sectionId:String?
    var pictureWidth:String?
    var subTitle:String?
    var targetId:String?
    var pictureHeight:String?
    var icon:String?
    var title:String?
    var feeMode:String?
    var targetType:String?
    var id:String?
    var dramaType:String?
    var shortDesc:String?
    var tag:String?
    var videoDurationStr:String?
    var coverUrl:String?
    var episodeCount:Int?
    var tags:String?
    var cornerMark:String?
    var dramaId:String?
    var score:String?
    var imageList:[ImageListModel]?
    var normalLabelList:[String]?
    var count:String?
    var operationFlag:Bool = false
    var vipFlag:String?
    var favorite:String?
    var specialLabelList:[String]?
}

struct ImageListModel:HandyJSON{
    var width:String?
    var height:String?
    var url:String?
}

struct BannerTopModel:HandyJSON {
    var filmTitle:String?
    var type:String?
    var filmSubtitle:String?
    var position:String?
    var id:String?
    var sequence:Int?
    var targetUrl:String?
    var redirectUrl:String?
    var title:String?
    var name:String?
    var filmScore:String?
    var imgUrl:String?
}
