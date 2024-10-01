//
//  AnAnAppDevice.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/27.
//

import UIKit

class AnAnAppDevice: NSObject {
    static func deviceTop() -> CGFloat{
        if #available(iOS 13.0, *){
            let set:NSSet = UIApplication.shared.connectedScenes as NSSet
            let windowScene:UIWindowScene = set.anyObject() as! UIWindowScene
            let window = windowScene.windows.first
            return window?.safeAreaInsets.top ?? 0
        }else if #available(iOS 11.0, *){
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.top ?? 0
        }
        return 0
    }
    
    static var deviceBottom: CGFloat{
        if #available(iOS 13.0, *){
            let set:NSSet = UIApplication.shared.connectedScenes as NSSet
            let windowScene:UIWindowScene = set.anyObject() as! UIWindowScene
            let window = windowScene.windows.first
            return window?.safeAreaInsets.bottom ?? 0
        }else if #available(iOS 11.0, *){
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    static var deviceLeft: CGFloat{
        if #available(iOS 13.0, *){
            let set:NSSet = UIApplication.shared.connectedScenes as NSSet
            let windowScene:UIWindowScene = set.anyObject() as! UIWindowScene
            let window = windowScene.windows.first
            return window?.safeAreaInsets.left ?? 0
        }else if #available(iOS 11.0, *){
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets.left ?? 0
        }
        return 0
    }
    
    static func statusBarHeight() -> CGFloat{
        if #available(iOS 13.0, *){
            let set:NSSet = UIApplication.shared.connectedScenes as NSSet
            let windowScene:UIWindowScene = set.anyObject() as! UIWindowScene
            let statusBarManager = windowScene.statusBarManager
            return statusBarManager?.statusBarFrame.size.height ?? 0
        }else{
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    
    static func navigationBarHeight() -> CGFloat{
        return 48
    }
    
    static func an_screenWidth() -> CGFloat{
        return UIScreen.main.bounds.size.width
    }
    
    static func an_screenHeight() -> CGFloat{
        return UIScreen.main.bounds.size.height
    }
    
    static let AnAnDefaultHttpScheme = "https://"
    
    static let AnAnServiceUrlFragment = "api."
//    弹幕域名
    static let AnAnServiceUrlDanmu = "static-dm."
    
    static let AnAnServiceDomainName = "duoduo.pro"
    
    static let AnAnServiceHeaderSignKey = "cf65GPholnICgyw1xbrpA79XVkizOdMq"
    
    static let AnAnAppVersion = "5.22.3"
    
    static let AnAnAppClientType = "ios_duoduoshipin"
}
