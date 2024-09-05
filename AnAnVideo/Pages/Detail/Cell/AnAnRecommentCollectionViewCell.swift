//
//  AnAnRecommentCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/23.
//  猜你喜欢

import UIKit

class AnAnRecommentCollectionViewCell: UICollectionViewCell {
    private lazy var movieCoverImageView:UIImageView = {
        let imageView = AnAnImageView()
        return imageView
    }()
    
    private lazy var collectBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_home_zhuiju_n"),selectImage: UIImage(named: "ic_home_zhuiju_h"),target: self,action: #selector(btnClick))
        return btn
    }()
    
    private lazy var scoreLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 17))
        label.textAlignment = .right
        return label
    }()
    
    private lazy var movieTitleLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangSemiboldWithSize(fontSize: 14))
        return label
    }()
    
    private lazy var movieSubTitle:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    private lazy var movieTypeImageView:UIImageView = {
        let imageView = AnAnImageView()
        imageView.image = UIImage(named: "ic_home_feed_ju")
        return imageView
    }()
    
    private lazy var movieTopButton:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_vip_more"),font:UIFont.pingFangSemiboldWithSize(fontSize: 12),fontColor:UIColor.hexadecimalColor(hexadecimal: An_F7B500),target: self ,action: #selector(btnClick))
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = .gray
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(movieCoverImageView)
        movieCoverImageView.addSubview(collectBtn)
        movieCoverImageView.addSubview(scoreLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieSubTitle)
        contentView.addSubview(movieTypeImageView)
        contentView.addSubview(movieTopButton)
    }
    
    private func setSubviewsFrame() {
        movieCoverImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(218)
        }
        collectBtn.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.size.equalTo(25)
        }
        scoreLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-8)
            make.bottom.equalTo(-4)
            make.size.equalTo(CGSize(width: 30, height: 17))
        }
        movieTypeImageView.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(movieCoverImageView.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 24, height: 34))
        }
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieTypeImageView.snp.trailing).offset(8)
            make.top.equalTo(movieTypeImageView.snp.top)
            make.height.equalTo(14)
            make.trailing.equalTo(-10)
        }
        movieSubTitle.snp.makeConstraints { make in
            make.leading.equalTo(movieTitleLabel)
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(6)
            make.height.equalTo(12)
            make.trailing.equalTo(-10)
        }
        movieTopButton.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(movieSubTitle.snp.bottom).offset(6)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
    }
    
    @objc func btnClick(){
        
    }
    
    var contentModel:ContentModel?{
        didSet{
            movieCoverImageView.layoutIfNeeded()
            movieCoverImageView.setImageWith(url: contentModel?.coverUrl ?? "")
            scoreLabel.text = String(format: "%.1f", contentModel?.score ?? 0.0) 
            movieTitleLabel.text = contentModel?.title
            movieSubTitle.text = contentModel?.subTitle
            if contentModel?.topInfoTag?.title != nil{
                movieTopButton.setTitle(contentModel?.topInfoTag?.title, for: .normal)
                movieTopButton.isHidden = false
            }else {
                movieTopButton.isHidden = true
            }
        }
    }
}
