//
//  AnAnHistoryItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/9.
//

import UIKit

class AnAnHistoryItemCollectionViewCell: UICollectionViewCell {
    private lazy var movieCoverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 13
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var movieNameLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangRegularWithSize(fontSize: 12))
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
        self.contentView.addSubview(movieCoverImageView)
        self.contentView.addSubview(movieNameLabel)
    }
    
    private func setSubviewsFrame() {
        
        movieCoverImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo((AnAnAppDevice.an_screenWidth()-60)/3 * 105/59)
        }
        movieNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(movieCoverImageView.snp.bottom).offset(6.5)
            make.height.equalTo(15)
        }
    }
}
