//
//  AnAnBarrageColorItemCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/10/26.
//

import UIKit

class AnAnBarrageColorItemCell: UICollectionViewCell {
    
    var colorName:String?{
        didSet{
            self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: colorName ?? An_E6E7E8)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
