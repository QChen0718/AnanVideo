//
//  AnAnSearchModel.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/12.
//

import UIKit
import HandyJSON

struct AnAnSearchModel: HandyJSON {
    var sheetList:[AnAnSheetModel] = []
    var actorCount:Int = 0
    var sheetCount:Int = 0
    var actorList:[AnAnactorModel]?
    var uperCount:Int = 0
    var seasonList:[AnAnMovieModel]? = []
    var recommendList:[String]? = []
    var videoCount:Int = 0
    var searchWordRelevant:String?
    var showState:String?
    var seasonSeriesDetails:String?
    var seasonCount:Int = 0
    var talkId:String?
    var videoList:[AnAnVideoModel]? = []
    var uperList:[String]? = []
}

struct AnAnSheetModel: HandyJSON {
    var color:String?
    var name:String?
    var series_type:String?
    var enable:Bool = false
    var original_name:String?
    var id:String?
    var search_after:String?
    var relevance_count:Int = 0
    var sheet_url:String?
    var content:[AnAnContentModel]?
}

struct AnAnContentModel:HandyJSON {
    var cover:String?
    var dramaId:String?
    var name:String?
                    
}

struct AnAnactorModel:HandyJSON {
    var sex:String?
    var originalName:String?
    var stageName:[String]?
    var relatedDramaList:[AnAnRelatedDramaModel]?
    var chineseName:String?
    var highlights:[AnAnHighlightModel]?
    var description:String?
    var birthday:String?
    var nationality:String?
    var id:String?
    var search_after:String?
    var headUrl:String?
    var communityEnable:Bool = false
    var nickName:[String]?
}

struct AnAnRelatedDramaModel:HandyJSON{
    var imageUrl:String?
    var feeMode:String?
    var enable:Bool = false
    var score:String?
    var dramaName:String?
    var roleName:String?
    var dramaId:String?
    var dramaType:String?

}

struct AnAnHighlightModel:HandyJSON{
    var original_name:String?
    var chinese_name:String?
    var nick_name:String?
    var stage_name:String?
}

struct AnAnMovieModel: HandyJSON {
    var title: String = ""
    var director: String = ""
    var cat: String = ""
    var score: Double? = nil
    var classify: String = ""
    var actor: String = ""
    var area: String = ""
    var tagSpecial: [String] = []
    var searchAfter: String = ""
    var subtitle: String = ""
    var year: String = ""
    var cover: String = ""
    var id: String = ""
    var highlights: HighlightsModel? = nil
    var feeMode: String = ""
    var recommendList: [RecommendationModel] = []
}

struct HighlightsModel: HandyJSON {
    var title: String = ""
    var searchWordInfo: String? = nil
    var originalName: String? = nil
    var alias: String? = nil
}

struct RecommendationModel: HandyJSON {
    var dramaId: Int = 0
    var tagName: String = ""
    var coverUrl: String = ""
    var itemType: String? = nil
    var title: String = ""
    var subTitle: String = ""
    var score: Double = 0.0
}

struct AnAnVideoModel:HandyJSON {
   var cover: String?
   var id: String?
   var author: AnAnAuthorModel?
   var title: String?
   var searchAfter: String?
   var likeCount: Int?
   var seasonInfo: AnAnSeasonInfo?
   var coverHeight: Int?
   var viewCount: Int?
   var liked: Bool?
   var duration: String?
   var sort: Int?
   var coverWidth: Int?
}

struct AnAnAuthorModel:HandyJSON{
    var id: String?
    var nickName: String?
    var headImgUrl: String?
}

struct AnAnSeasonInfo: HandyJSON {
   var title: String?
   var id: Int?
   var dramaId: Int?
   var cover: String?
}
