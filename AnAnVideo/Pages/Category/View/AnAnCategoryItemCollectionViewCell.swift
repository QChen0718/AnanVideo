//
//  AnAnCategoryItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnCategoryItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var movieCoverImageView:UIImageView = {
        let imageView = AnAnImageView()
        imageView.layer.cornerRadius = 17
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var vipIcon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_vip_corner_mark")
        return imageView
    }()
    
    private lazy var movieNameLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"龙之家族",fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangMediumWithSize(fontSize: 14))
        return label
    }()
    
    private lazy var descLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"重生复仇记",fontColor: UIColor.hexadecimalColor(hexadecimal: An_84879A), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
        self.setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        self.contentView.addSubview(movieCoverImageView)
        self.movieCoverImageView.addSubview(vipIcon)
        self.contentView.addSubview(movieNameLabel)
        self.contentView.addSubview(descLabel)
    }
    
    private func setSubviewsFrame() {
        
        movieCoverImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.frame.size.width * 136.5/105)
        }
        
        vipIcon.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: 38.5, height: 20))
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(movieCoverImageView.snp.bottom).offset(10)
            make.height.equalTo(17)
        }
        
        descLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(movieNameLabel.snp.bottom).offset(4)
            make.height.equalTo(15)
        }
    }
    
    var model:AnAnCategoryDataModel?{
        didSet{
            movieCoverImageView.setImageWith(url: model?.coverUrl ?? "")
            movieNameLabel.text = model?.title ?? ""
            descLabel.text = model?.subtitle ?? ""
        }
    }
}
