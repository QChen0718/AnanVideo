//
//  AnAnDownloadPcdnUrl.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/15.
//  获取七牛pcdn下载地址

import UIKit

class AnAnDownloadPcdnUrl: NSObject {
    private var enableQNForDownload:Bool = false
    
    static let shareDownloadPcdn = AnAnDownloadPcdnUrl()
    
//    启动pcdn服务
    func an_startTitanSDK() {
//        先默认都开启pcdn
        enableQNForDownload = true
        TitanSDK.setToken(0x715069B7)
//        启动服务
        TitanSDK.start()
    }
//    停止服务
    func an_stopTitanSDK() {
        TitanSDK.stop()
    }
    
//    读取七牛pcdn下载地址，cdn限速
    func an_rewriteDownloadUrl(url:String) -> String {
        var newUrl:String = ""
        if url.contains("?") {
            newUrl = url.appending("&c=1")
        }else {
            newUrl = url.appending("?c=1")
        }
//        使用pcdn
        if enableQNForDownload {
            var optionDict:[String:Any] = [:]
            let bootLen = 300000
            let timeout = 2500
//            取服务端配置的限速
            let qnDownloadLimit = 0.5
            let rateLimit = qnDownloadLimit*8*1024*1024
            optionDict["SCHED_BOOT_LEN"] = bootLen
            optionDict["SCHED_BOOT_TIMEOUT"] = timeout
//            不是VIP进行限速
            if AnAnUserData.isVip{
                optionDict["SCHED_RATE_LIMIT"] = rateLimit
            }
//          字典转data
            let optionJsonData = try? JSONSerialization.data(withJSONObject: optionDict,options: .fragmentsAllowed)
            
            if optionJsonData == nil {
                return newUrl
            }
            if let jsonData = optionJsonData{
                let optionJsonStr = String(data: jsonData, encoding: .utf8)
                if optionJsonStr == nil {
                    return newUrl
                }
                var rewriteUrl:String?
    //            判断URL是否是m3u8地址
                if newUrl.isM3u8UrlString(){
                    rewriteUrl = TitanSDK.getVodUrl(newUrl, option: optionJsonStr)
                }else{
                    rewriteUrl = TitanSDK.getDownloadUrl(newUrl, option: optionJsonStr)
                }
                if rewriteUrl != newUrl {
                    newUrl = rewriteUrl ?? ""
                }
            }
        }
        return newUrl
    }
}
