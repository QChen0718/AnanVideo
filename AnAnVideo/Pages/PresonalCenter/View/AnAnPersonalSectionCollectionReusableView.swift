//
//  AnAnPersonalSectionCollectionReusableView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/11.
//

import UIKit

class AnAnPersonalSectionCollectionReusableView: UICollectionReusableView {
    
    lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangSemiboldWithSize(fontSize: 20))
        return label
    }()
    
    lazy var arrowImg:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_me_more")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(arrowImg)
    }
    
    private func setSubviewsFrame() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalToSuperview()
            make.trailing.equalTo(arrowImg.snp.leading).offset(-10)
            make.height.equalTo(24)
        }
        arrowImg.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
    }
}
