//
//  AnAnPeriodItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/25.
//

import UIKit

class AnAnPeriodItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var bgImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "rectangle_1")
        return imageView
    }()
    
    private lazy var periodLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_BABCC2), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        label.text = "第一季"
        label.textAlignment = .center
        return label
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
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(periodLabel)
    }
    
    private func setSubviewsFrame() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        periodLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
