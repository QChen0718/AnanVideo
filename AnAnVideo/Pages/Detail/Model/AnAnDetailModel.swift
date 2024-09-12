//
//  AnAnDetailModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/18.
//

import UIKit
import HandyJSON

struct AnAnDetailModel: HandyJSON {
    var watchInfo:WatchInfoModel?
    var sortedItems:[SortedItemModel]?
    var dramaInfo:DramaInfoModel?
    var authorityInfo:AuthorityInfoModel?
    var dramaCompliance:DramaComplianceModel?
    var trailerList:[String]?
    var fiveMinutePlayInfo:String?
    var episodeList:[EpisodeListModel]?
}

struct WatchInfoModel: HandyJSON {
    var m3u8:M3u8Model?
    var sortedItems:[SortedItemModel]?
}

struct SortedItemModel:HandyJSON {
    var canPlay:Bool?
    var initialQuality:Bool?
    var qualityCode:String?
    var qualityDescription:String?
    var canShowLogin:Bool?
    var canShowVip:Bool?
}

struct M3u8Model:HandyJSON {
    var mediaId:String?
    var cacheSize:String?
    var externalAds:Bool = false
    var header:String?
    var currentQuality:String?
    var commentRestricted:Bool = false
    var size:String?
    var parseTime:String?
    var startingLength:Int?
    var url:String?
    var openingLength:Int?
    var subtitle:[String]?
    var episodeSid:String?
}

struct DramaInfoModel:HandyJSON {
    var cover:String?
    var imageList:[String]?
    var dramaId:String?
    var feeMode:String?
    var title:String?
    var year:String?
    var seasonNo:Int?
    var plotType:String?
    var enName:String?
    var enable:Bool?
    var dramaType:String?
    var normalTagList:[String]?
    var area:String?
    var score:Float?
    var seasonType:String?
    var playStatus:String?
    var cornerMark:String?
    var subtitle:String?
    var hotType:Int?
    var serialStatus:String?
    var specialTagList:[String]?
}

struct AuthorityInfoModel:HandyJSON{
    var commentRestricted:Bool?
    var downloadRestricted:Bool?
    var playRestricted:Int?
    var shareRestricted:Bool?
}

struct DramaComplianceModel:HandyJSON{
    var approvalNumber:String?
    var durationTime:String?
    var registrationNumber:String?
}

struct EpisodeListModel:HandyJSON {
    var id:String?
    var episodeNo:String?
    var text:String?
    var title:String?
    var sid:String?
    var feeMode:String?
    var isDownloading:Bool?
    var isDownloadSuccess:Bool?
}


struct SeconDarayModel:HandyJSON {
    var discussionsCount:String = ""
    var hotType:Int = 0
    var gradeValue:Int = 0
    var favoriteTriggerType:String = ""
    var favorite:Bool = false
    var reviewCount:String = ""
    var dramaId:String = ""
    var author:AuthorModel?
    var topInfo:TopInfoModel?
    var role:[String]?
    var dramaSeriesList:[DramaSeriesListModel]?
    var favoriteStatus:String = ""
}


struct AuthorModel:HandyJSON{
    var headImgUrl:String = ""
    var id:String = ""
    var nickName:String = ""
}

struct TopInfoModel:HandyJSON {
    var id:String = ""
    var title:String?
}

struct DramaSeriesListModel:HandyJSON {
    var dramaId:String = ""
    var seriesName:String = ""
    var normalImageName:String = ""
    var selectImageName:String = ""
    var isCurPlay:Bool = false
}


//
struct DramaIntroModel:HandyJSON {
    var intro:String = ""
    var dramaId:String = ""
    var plotType:String = ""
    var year:String = ""
    var actorList:[ActorListModel]?
    var subTitle:String = ""
    var title:String = ""
    var author:AuthorModel?
    var area:String = ""
}

struct ActorListModel:HandyJSON {
    var roleName:String = ""
    var headUrl:String = ""
    var chineseName:String = ""
    var id:String = ""
    var mainActor:Bool = false
}

struct DramaModuleModel:HandyJSON {
    var moduleList:[ModuleListModel]?
    var recommendedDramaPlayable:String = ""
    var recommendedDramaModuleTitle:String = ""
}

struct ModuleListModel:HandyJSON {
    var moduleTitle:String = ""
    var dramaAlbumList:[DramaAlbumListModel]?
    var playable:String = ""
    var videoList:[String] = []
    var moduleType:String = ""
    var videoAlbum:String = ""
    var actorList:[ActorListModel]?
    var id:String = ""
}

struct DramaAlbumListModel:HandyJSON {
    var subTitle:String = ""
    var color:String = ""
    var name:String = ""
    var id:String = ""
    var images:[String] = []
}

struct RecommendListModel:HandyJSON {
    var content:[ContentModel]?
}

struct ContentModel:HandyJSON {
    var recomTraceInfo:String = ""
    var score:Float = 0.0
    var favorite:Bool = false
    var dramaType:String = ""
    var topInfoTag:TopInfoModel?
    var recomTraceId:String = ""
    var subTitle:String = ""
    var display:String = ""
    var dramaId:String = ""
    var feeMode:String = ""
    var specialLabelList:[String] = []
    var coverUrl:String = ""
    var title:String = ""
    var normalLabelList:[String] = []
    var otherInfoTag:String = ""
    var itemType:String = ""
}

