//
//  AnAnButton.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnButton: UIButton {
    static func createButton(title:String? = nil,image:UIImage? = nil,selectImage:UIImage? = nil,font:UIFont? = nil,fontColor:UIColor? = nil,bgColor:UIColor? = nil,target:Any ,action:Selector) -> UIButton{
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setImage(image, for: .normal)
        btn.setImage(selectImage, for: .selected)
        btn.setTitleColor(fontColor, for: .normal)
        btn.titleLabel?.font = font
        btn.backgroundColor = bgColor
        btn.addTarget(target, action: action, for: .touchUpInside)
        return btn
    }
}
