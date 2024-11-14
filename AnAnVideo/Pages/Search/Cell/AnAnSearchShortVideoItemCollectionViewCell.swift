//
//  AnAnSearchShortVideoItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchShortVideoItemCollectionViewCell: UICollectionViewCell {
    
    lazy var videoCoverImg:UIImageView = {
       let img = UIImageView()
        img.layer.cornerRadius = 8
        img.layer.masksToBounds = true
        img.backgroundColor = .lightGray
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var videoTimeLab:UILabel = {
       let lab = UILabel()
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 12, weight: .semibold)
        lab.textAlignment = .right
        return lab
    }()
    
    lazy var videoNameLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 14, weight: .semibold)
        lab.numberOfLines = 2
        return lab
    }()
    
    lazy var userHeaderImg:UIImageView = {
       let img = UIImageView()
        img.layer.cornerRadius = 6
        img.layer.masksToBounds = true
        return img
    }()
    
    lazy var userNameLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
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
        contentView.backgroundColor = .white
        contentView.addSubview(videoCoverImg)
        videoCoverImg.addSubview(videoTimeLab)
        contentView.addSubview(videoNameLab)
        contentView.addSubview(userHeaderImg)
        contentView.addSubview(userNameLab)
        contentView.addSubview(likeBtn)
        videoCoverImg.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(94)
        }
        videoTimeLab.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(12)
        }
        videoNameLab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(videoCoverImg.snp.bottom).offset(10)
        }
        userHeaderImg.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.bottom.equalToSuperview().inset(13)
            make.size.equalTo(12)
        }
        userNameLab.snp.makeConstraints { make in
            make.leading.equalTo(userHeaderImg.snp.trailing).offset(4)
            make.centerY.equalTo(userHeaderImg)
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
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.hexadecimalColor(hexadecimal: An_000000,alpha: 0.08).cgColor
        contentView.layer.shadowOffset = CGSizeMake(0, 5)
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 15
    }
    
    @objc func likeBtnClick(){
        
    }
}
