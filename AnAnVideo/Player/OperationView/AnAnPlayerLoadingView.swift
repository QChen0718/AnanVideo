//
//  AnAnPlayerLoadingView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/21.
//

import UIKit

class AnAnPlayerLoadingView: UIView {

    private lazy var loadingImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "img_video_loading")
        return imageView
    }()
    private lazy var loadingLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"加载中...",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 16))
        label.textAlignment = .center
        label.alpha = 0.8
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        addSubview(loadingImageView)
        addSubview(loadingLabel)
        loadingImageView.rotate360Degree()
    }
    
    private func setSubviewsFrame() {
        loadingImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(28)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        loadingLabel.snp.makeConstraints { make in
            make.top.equalTo(loadingImageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(16)
        }
    }
    
}
