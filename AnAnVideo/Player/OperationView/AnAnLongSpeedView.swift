//
//  AnAnLongSpeedView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2024/9/22.
//  长按倍速提示view

import UIKit

class AnAnLongSpeedView: UIView {
    lazy var iconImg:UIImageView = {
       let img = UIImageView(image: UIImage(named: "ic_player"))
        return img
    }()
    
    lazy var speedLab:UILabel = {
        let attributedStr = NSMutableAttributedString(string: " 2X 倍速播放中", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_FFFFFF),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .regular)])
        attributedStr.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_216DFF),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .semibold)], range: NSRange(location: 0, length: 4))
        let lab = UILabel()
        lab.attributedText = attributedStr
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000).withAlphaComponent(0.7)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addSubview(iconImg)
        addSubview(speedLab)
        iconImg.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        speedLab.snp.makeConstraints { make in
            make.leading.equalTo(iconImg.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
