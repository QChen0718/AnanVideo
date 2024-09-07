//
//  AnAnFilterModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/3.
//

import UIKit
import HandyJSON

struct AnAnFilterModel: HandyJSON {
    var filterType:String?
    var dramaFilterItemList:[AnAnFilterItemModel]?
}

struct AnAnFilterItemModel:HandyJSON {
    var displayName:String?
    var value:String?
}
/*
{
  "coverUrl" : "http:\/\/img.ddtv.plus\/friday\/drama\/20240731\/o_90235b24c8cb4d3e9a5feb4e0a1b6264.webp",
  "seasonNo" : 0,
  "specialLabelList" : [
    "渣女",
    "豪门"
  ],
  "isFavorite" : null,
  "score" : "7.2",
  "feeMode" : "free",
  "dramaId" : 49735,
  "subtitle" : "在这个社会里，男人就是我上升的阶梯",
  "title" : "金色光芒",
  "cornerMark" : "",
  "dramaType" : "TV"
},
*/
struct AnAnCategoryDataModel:HandyJSON {
    var coverUrl : String?
    var dramaId : String?
    var subtitle : String?
    var title : String?
}
