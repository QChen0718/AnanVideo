//
//  AnAnScreenTool.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/18.
//

import UIKit

public class AnAnScreenTool {
    static let shared = AnAnScreenTool()
        
    /// 标记：当前是否在代码里强制旋转
    var isForcingOrientation = false
    let myAppdelegate = UIApplication.shared.delegate as? AppDelegate
    func switchScreenOrientation(vc:UIViewController, mode: SCREEN_SET,deviceOrientation:UIDeviceOrientation = .portrait) {
        myAppdelegate?.screen_set = mode
        if #available(iOS 16.0, *) {
            /// ios 16以上需要通过scene来实现屏幕方向设置
            isForcingOrientation = true
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            switch mode {
            case .set_port:
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait))
                break
            case .set_land:
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
                break
            case .set_auto:
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .all))
                break
            }
            vc.setNeedsUpdateOfSupportedInterfaceOrientations()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                AnAnScreenTool.shared.isForcingOrientation = false
            }
        }else{
            UIViewController.attemptRotationToDeviceOrientation()
            
            isForcingOrientation = true
            switch mode {
            case .set_port:
                //                强制设置竖屏
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                break
            case .set_land:
                //                强制设置横屏
                if deviceOrientation == .landscapeLeft {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                }else{
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                }
                
                break
            case .set_auto:
                //                设置自动旋转
                UIDevice.current.setValue(UIInterfaceOrientation.unknown.rawValue, forKey: "orientation")
                break
            }
            // 给系统一点时间把方向调完，再允许监听
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                AnAnScreenTool.shared.isForcingOrientation = false
            }
        }
    }
}
