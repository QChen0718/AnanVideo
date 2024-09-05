//
//  AnAnLabel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnLabel: UILabel {
    
    static func createLabel(text:String? = "",fontColor:UIColor?,bgColor:UIColor? = .clear,font:UIFont?,numberOfLines:Int = 1) -> UILabel{
        let label = UILabel()
        label.text = text
        label.textColor = fontColor
//        label.backgroundColor = bgColor
        label.font = font
        label.numberOfLines = numberOfLines 
        return label
    }
}
