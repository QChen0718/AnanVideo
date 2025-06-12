//
//  AnAnJumpPageManager.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/12.
//

import UIKit

class AnAnJumpPageManager: NSObject {
    static let shared = AnAnJumpPageManager()
//    获取当前控制器

    var currentVC: UIViewController? {
        var resultVC: UIViewController?
        resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
        while resultVC?.presentedViewController != nil {
            resultVC = _topVC(resultVC?.presentedViewController)
        }
        return resultVC
    }

//    获取当前导航栏
    
    var currentNav:UINavigationController? {
        var resultNav:UIViewController?
        resultNav = UIApplication.shared.keyWindow?.rootViewController
        if resultNav is UINavigationController {
            return resultNav as? UINavigationController
        }
        return nil
    }
    
    private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
        if vc is UINavigationController {
            return _topVC((vc as? UINavigationController)?.topViewController)
        } else if vc is UITabBarController {
            return _topVC((vc as? UITabBarController)?.selectedViewController)
        } else {
            return vc
        }
    }
    
//    根视图
   static var isRootViewControllers:Bool{
        if let currentVC = AnAnJumpPageManager.shared.currentVC{
            if currentVC.isKind(of: AnAnHomeViewController.self) || currentVC.isKind(of: AnAnCategoryViewController.self) || currentVC.isKind(of: AnAnMeViewController.self) || currentVC.isKind(of: AnAnShortVideoViewController.self){
                return true
            }
        }
        return false
    }
    
    static func goToLoginPage() {
        let vc = AnAnLoginViewController()
        AnAnJumpPageManager.shared.currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotToDetailPage(dramaId:String) {
        let vc = AnAnVideoDetailViewController()
        vc.dramaId = dramaId
        AnAnJumpPageManager.shared.currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToDownloadPage(isLookDownloading:Bool = false){
        let vc = AnAnDownloadViewController()
        vc.isLookDownloading = isLookDownloading
        AnAnJumpPageManager.shared.currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToSeetingPage() {
        let vc = AnAnSettingViewController()
        AnAnJumpPageManager.shared.currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func backPage(){
        AnAnJumpPageManager.shared.currentVC?.navigationController?.popViewController(animated: true)
    }
    
    static func goToSearchPage() {
        let vc = AnAnSearchViewController()
        AnAnJumpPageManager.shared.currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToSearchResultPage(keyword:String) {
        let vc = AnAnSearchResultViewController()
        vc.searchKey = keyword
        AnAnJumpPageManager.shared.currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToHistoryPage(){
        let vc = AnAnHistoryViewController()
        AnAnJumpPageManager.shared.currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func goToVipPage(){
        let vc = AnAnPayViewController()
        AnAnJumpPageManager.shared.currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
}
