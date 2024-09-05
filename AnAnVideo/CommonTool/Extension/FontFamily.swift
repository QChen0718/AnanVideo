//
//  FontFamily.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/1.
//

import UIKit

extension UIFont{
    static func pingFangSemiboldWithSize(fontSize:CGFloat) -> UIFont {
        var name = String(format: "PingFangSC-%@", "Semibold")
        var font = UIFont(name: name, size: fontSize)
        guard let customFont = font else {
            name = String(format: "Helvetica-%@", "Bold")
            font = UIFont(name: name, size: fontSize)
            return font!
        }
        return customFont
    }
    
    static func pingFangHeavyWithSize(fontSize:CGFloat) -> UIFont {
        var name = String(format: "PingFangSC-%@", "Heavy")
        var font = UIFont(name: name, size: fontSize)
        guard let customFont = font else {
            name = String(format: "Helvetica-%@", "Bold")
            font = UIFont(name: name, size: fontSize)
            return font!
        }
        return customFont
    }
    
    static func pingFangMediumWithSize(fontSize:CGFloat) -> UIFont {
        var name = String(format: "PingFangSC-%@", "Medium")
        var font = UIFont(name: name, size: fontSize)
        guard let customFont = font else {
            name = String(format: "Helvetica-%@", "Bold")
            font = UIFont(name: name, size: fontSize)
            return font!
        }
        return customFont
    }
    
    static func pingFangRegularWithSize(fontSize:CGFloat) -> UIFont {
        let name = String(format: "PingFangSC-%@", "Regular")
        let font = UIFont(name: name, size: fontSize)
        guard let customFont = font else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return customFont
    }
    
    static func bebasNeueRegularWithSize(fontSize:CGFloat) -> UIFont {
        let name = String(format: "BebasNeue-%@", "Regular")
        let font = UIFont(name: name, size: fontSize)
        guard let customFont = font else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return customFont
    }
    
    static func youSheBiaoRegularWithSize(fontSize:CGFloat) -> UIFont {
        let font = UIFont(name: "YouSheBiaoTiHei", size: fontSize)
        guard let customFont = font else {
            return UIFont.boldSystemFont(ofSize: fontSize)
        }
        return customFont
    }
    
    static func orbitronSemiBoldWithSize(fontSize:CGFloat) -> UIFont {
        let name = String(format: "Orbitron-%@", "SemiBold")
        let font = UIFont(name: name, size: fontSize)
        guard let customFont = font else {
            return UIFont.boldSystemFont(ofSize: fontSize)
        }
        return customFont
    }
}
