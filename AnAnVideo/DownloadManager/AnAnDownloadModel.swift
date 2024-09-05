//
//  AnAnDownloadModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/14.
//

import UIKit
import HandyJSON

typealias UpdateDownloadProgressBlock = (String?,CGFloat?)->Void //更新下载进度
typealias UpdateDownloadSpeedBlock = (String?,String)->Void //更新下载速度
typealias CancelDownloadBlock = ()->Void //取消下载
typealias WaitDownloadBlock = ()->Void //等待下载
//typealias FailDownloadBlock = (AnAnDownloadStatus)->Void //下载失败
typealias StartDownloadBlock = ()->Void //开始下载
// 
class AnAnDownloadModel: NSObject {
    var fileId:String?  //文件ID
    var dramaId:String? //剧集ID
    var filePath:String? //存储路径
    var fileName:String? //文件名称
    var downloadUrl:String? //下载地址
    var totalSize:Int64 = 0 //文件总大小
    var currentSize:Int64 = 0 //已下载文件大小
    var oldSize:Int64 = 0   //上一秒下载的数据
//    var downloadStatus:AnAnDownloadStatus? //下载状态
    var handle:FileHandle? //文件句柄
    var task:URLSessionDataTask? //下载任务
    var movieCover:String? //视频封面
    var progress:CGFloat = 0 //视频下载进度
    var movieTitle:String? //视频标题
    var downloadSpeed:String? //下载速度
    var episodeNo:String?
    var episodeId:String?
    var seasonNo:String?
    //  重试次数
    var retryCount:Int = 3
    var updateDownloadProgressBlock:UpdateDownloadProgressBlock?
    var updateDownloadSpeedBlock:UpdateDownloadSpeedBlock?
    var cancelDownloadBlock:CancelDownloadBlock?
    var waitDownloadBlock:WaitDownloadBlock?
//    var failDownloadBlock:FailDownloadBlock?
    var startDownloadBlock:StartDownloadBlock?
}

struct AnAnDownloadInfoModel:HandyJSON{
    var m3u8:M3U8Model?
}

struct M3U8Model:HandyJSON{
    var cacheSize:Int64 = 0
    var commentRestricted:Int = 0
    var currentQuality:String = "SD"
    var externalAds:Int = 0
    var header:String = ""
    var mediaId:String = ""
    var openingLength:Int = 0
    var parseTime:String = ""
    var size:String = "";
    var startingLength:Int = 0
    var subtitle:[String] = []
    var url:String = ""
}
