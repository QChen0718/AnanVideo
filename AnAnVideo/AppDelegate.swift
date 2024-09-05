//
//  AppDelegate.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

import UIKit

enum SCREEN_SET {
    case set_port
    case set_land
    case set_auto
}

func synced(_ lock: Any, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
//  全局变量
    var screen_set:SCREEN_SET = .set_port
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = AnAnTabBarViewController()
        window?.makeKeyAndVisible()
//        启动APP开启pcdn服务
        AnAnDownloadPcdnUrl.shareDownloadPcdn.an_startTitanSDK()
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if screen_set == .set_port {
            return .portrait
        }else if screen_set == .set_land{
            return .landscape
        }
        return .all
    }

}

