//
//  AnAnNotifacationName.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/12.
//

import UIKit

class AnAnNotifacationName {
//    切换剧集
    static let SwitchEpisode = Notification.Name(rawValue: "SwitchEpisode")
//    切换季
    static let SwitchSeaction = Notification.Name(rawValue: "SwitchSeaction")
//    弹出下载视图
    static let PopDownloadView = Notification.Name(rawValue: "PopDownloadView")
//    获取下载地址信息
    static let VideoDownloadInfo = Notification.Name(rawValue: "VideoDownloadInfo")
//    更新视频下载进度
    static let UpdateVideoDownloadProgress = Notification.Name(rawValue: "UpdateVideoDownloadProgress")
//    删除下载任务
    static let deleteDownloadTask = Notification.Name(rawValue: "deleteDownloadTask")
    
}
