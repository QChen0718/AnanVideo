//
//  AnAnShortModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/6/18.
//

import UIKit
import HandyJSON

struct AnAnShortModel: HandyJSON {
    var album:AlbumModel?
    var author:AuthorModel?
    var collectCount:Int = 0
    var commentCount:Int = 0
    var cover:String = ""
    var id:Int = 0
    var likeCount:Int = 0
    var playCount:Int = 0
    var playLink:String = ""
    var season:SeasonModel?
    var title:String = ""
    var videoDuration:Int = 0
}

struct AlbumModel:HandyJSON {
    var id:Int = 0
    var title:String = ""
}

struct SeasonModel:HandyJSON {
    var area:String = ""
    var authorScore:Int = 0
    var category:String = ""
    var collected:Int = 0
    var cover:String = ""
    var id:Int = 0
    var intro:String = ""
    var score:String = ""
    var seasonName:String = ""
    var subTitle:String = ""
    var title:String = ""
    var year:Int = 0
}
