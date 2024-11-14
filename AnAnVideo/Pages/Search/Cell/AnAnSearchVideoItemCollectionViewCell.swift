//
//  AnAnSearchVideoItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchVideoItemCollectionViewCell: UICollectionViewCell {
    
    lazy var vidoeCover:UIImageView = {
       let img = UIImageView()
        img.backgroundColor = .lightGray
        img.layer.cornerRadius = 8
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var videoNameLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 17, weight: .semibold)
        return lab
    }()
    
    lazy var videoTagLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    lazy var subTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    lazy var searchTagCollection:AnAnSearchVideoTagCollectionview = {
        let view = AnAnSearchVideoTagCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.addSubview(vidoeCover)
        contentView.addSubview(videoNameLab)
        contentView.addSubview(videoTagLab)
        contentView.addSubview(subTitleLab)
        contentView.addSubview(searchTagCollection)
        vidoeCover.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        videoNameLab.snp.makeConstraints { make in
            make.leading.equalTo(vidoeCover.snp.trailing).offset(12)
            make.top.equalTo(vidoeCover.snp.top).offset(6.5)
            make.trailing.equalToSuperview().inset(16)
        }
        videoTagLab.snp.makeConstraints { make in
            make.leading.trailing.equalTo(videoNameLab)
            make.top.equalTo(videoNameLab.snp.bottom).offset(12)
        }
        subTitleLab.snp.makeConstraints { make in
            make.leading.trailing.equalTo(videoNameLab)
            make.top.equalTo(videoTagLab.snp.bottom).offset(10)
        }
        searchTagCollection.snp.makeConstraints { make in
            make.leading.trailing.equalTo(videoNameLab)
            make.top.equalTo(videoTagLab.snp.bottom).offset(10)
            make.height.equalTo(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
