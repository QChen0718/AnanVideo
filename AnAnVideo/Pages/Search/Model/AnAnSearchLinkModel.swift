//
//  AnAnSearchLinkModel.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit
import HandyJSON

struct AnAnSearchLinkModel: HandyJSON {
    var seasonList:[AnAnSeasonListModel]?
    var searchTips:[AnAnSearchTipModel]?
}
struct AnAnSeasonListModel: HandyJSON {
    var classify:String?
    var id:String?
    var upInfo:String?
    var highlights:[AnAnSearchHighlightModel]?
    var cover:String?
    var brief:String?
    var sort:String?
    var subtitle:String?
    var cat:String?
    var status:String?
    var area:String?
    var actor:String?
    var search_after:String?
    var view_count:String?
    var score:String?
    var year:String?
    var title:String?
    var director:String?
}

struct AnAnSearchTipModel: HandyJSON {
    var title:String?
}

struct AnAnSearchHighlightModel: HandyJSON{
    var title:String?
}
