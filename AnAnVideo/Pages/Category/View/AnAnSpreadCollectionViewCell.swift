//
//  AnAnSpreadCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnSpreadCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"展开",fontColor: UIColor.hexadecimalColor(hexadecimal: An_84879A), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    private lazy var icon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_fenlei_zhankai")
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
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(icon)
    }
    
    private func setSubviewsFrame() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-7)
            make.size.equalTo(CGSize(width: 24, height: 15))
        }
        
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
            make.size.equalTo(12)
        }
    }
}
