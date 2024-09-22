//
//  AnAnVolumeView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2024/9/22.
//  调节音量

import UIKit

class AnAnVolumeView: UIView {
    
    lazy var progressView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_216DFF ,alpha: 0.8)
        return view
    }()
    
    lazy var volumeIcon:UIImageView = {
       let img = UIImageView(image: UIImage(named: "ic_voice0"))
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000, alpha: 0.3)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addSubview(progressView)
        addSubview(volumeIcon)
        progressView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.trailing.equalTo(30)
        }
        volumeIcon.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
