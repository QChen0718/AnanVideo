//
//  AnAnSearchPDItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchPDItemCollectionViewCell: UICollectionViewCell {
    
    lazy var videoCover1Img:UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 8
        img.layer.masksToBounds = true
        img.backgroundColor = .lightGray
        return img
    }()
    
    lazy var videoCover2Img:UIImageView = {
        let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.layer.cornerRadius = 8
         img.layer.masksToBounds = true
         img.backgroundColor = .lightGray
         return img
    }()
    
    lazy var videoCover3Img:UIImageView = {
        let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.layer.cornerRadius = 8
         img.layer.masksToBounds = true
         img.backgroundColor = .lightGray
         return img
    }()
    
    lazy var videoNameLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 14, weight: .semibold)
        return lab
    }()
    
    lazy var bottomBgImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var tagCollection:AnAnSearchVideoTagCollectionview = {
        let view = AnAnSearchVideoTagCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    lazy var userBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("乌鸦电影", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_85888F), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 11, weight: .regular)
        btn.addTarget(self, action: #selector(userBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var likeBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_common_like_n_28"), for: .normal)
        btn.setImage(UIImage(named: "ic_common_like_h_28"), for: .selected)
        btn.setTitle("1340", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_85888F), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 11, weight: .regular)
        btn.addTarget(self, action: #selector(likeBtnClick), for: .touchUpInside)
        btn.contentHorizontalAlignment = .right
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubview(videoCover3Img)
        contentView.addSubview(videoCover2Img)
        contentView.addSubview(videoCover1Img)
        contentView.addSubview(videoNameLab)
        contentView.addSubview(bottomBgImg)
        contentView.addSubview(tagCollection)
        contentView.addSubview(userBtn)
        contentView.addSubview(likeBtn)
        videoCover1Img.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(10)
            make.size.equalTo(CGSize(width: 80, height: 104))
        }
        videoCover2Img.snp.makeConstraints { make in
            make.leading.equalTo(videoCover1Img.snp.leading).offset(44)
            make.top.equalTo(videoCover1Img.snp.top).offset(10)
            make.bottom.equalTo(videoCover1Img)
            make.width.equalTo(72)
        }
        videoCover3Img.snp.makeConstraints { make in
            make.leading.equalTo(videoCover2Img.snp.leading).offset(39.5)
            make.top.equalTo(videoCover2Img.snp.top).offset(10)
            make.bottom.equalTo(videoCover2Img)
            make.width.equalTo(64)
        }
        bottomBgImg.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        videoNameLab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(videoCover1Img.snp.bottom).offset(10)
        }
        tagCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(videoNameLab.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
        userBtn.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.bottom.equalToSuperview().inset(10)
            make.size.equalTo(16)
        }
        likeBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 100, height: 14))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        contentView.layer.shadowColor = UIColor.hexadecimalColor(hexadecimal: An_000000,alpha: 0.08).cgColor
        contentView.layer.shadowOffset = CGSizeMake(0, 0)
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 15
    }
    
    @objc func userBtnClick(){
        
    }
    
    @objc func likeBtnClick(){
        
    }
    
    var pdmodel:AnAnPDModel?{
        didSet{
            guard let content = pdmodel?.covers else { return  }
            for (i,url) in content.enumerated() {
                if i == 0 {
                    videoCover1Img.setImageWith(url: url)
                }else if i == 1 {
                    videoCover2Img.setImageWith(url: url)
                }else{
                    videoCover3Img.setImageWith(url: url)
                }
            }
            videoNameLab.text = pdmodel?.title
            userBtn.setTitle(pdmodel?.authorName, for: .normal)
            likeBtn.setTitle("\(pdmodel?.likeCount ?? 0)", for: .normal)
        }
    }
}
