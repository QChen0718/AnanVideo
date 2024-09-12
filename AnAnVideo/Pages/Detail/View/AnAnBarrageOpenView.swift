//
//  AnAnBarrageOpenView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/12.
//

import UIKit

class AnAnBarrageOpenView: UIView {

    fileprivate lazy var barrageLab:UILabel = {
        let lab = AnAnLabel.createLabel(text:"发弹幕",fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: .systemFont(ofSize: 12, weight: .regular))
        return lab
    }()
    
    fileprivate lazy var barrageImg:UIImageView = {
        let img = AnAnImageView.createImageView(name: "ic_common_barrage_on")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_F2F4F7).cgColor
        addSubview(barrageLab)
        addSubview(barrageImg)
        barrageLab.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerY.equalToSuperview()
        }
        barrageImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(9)
            make.centerY.equalToSuperview()
            make.size.equalTo(13)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
