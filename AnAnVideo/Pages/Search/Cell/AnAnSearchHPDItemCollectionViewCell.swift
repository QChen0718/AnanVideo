//
//  AnAnSearchHPDItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchHPDItemCollectionViewCell: UICollectionViewCell {
    
    lazy var videoCover1Img:UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 6
        img.layer.masksToBounds = true
        img.backgroundColor = .lightGray
        return img
    }()
    
    lazy var videoCover2Img:UIImageView = {
        let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.layer.cornerRadius = 6
         img.layer.masksToBounds = true
         img.backgroundColor = .lightGray
         return img
    }()
    
    lazy var videoCover3Img:UIImageView = {
        let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.layer.cornerRadius = 6
         img.layer.masksToBounds = true
         img.backgroundColor = .lightGray
         return img
    }()
    
    lazy var videoNameLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF)
        lab.font = .systemFont(ofSize: 17, weight: .semibold)
        lab.numberOfLines = 2
        return lab
    }()
    
    lazy var arrowIcoImg:UIImageView = {
       let img = UIImageView(image: UIImage(named: ""))
        return img
    }()
    
    lazy var videoNumberLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.65)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(videoCover1Img)
        contentView.addSubview(videoCover2Img)
        contentView.addSubview(videoCover3Img)
        contentView.addSubview(videoNameLab)
        contentView.addSubview(arrowIcoImg)
        contentView.addSubview(videoNumberLab)
        videoCover1Img.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
            make.size.equalTo(CGSize(width: 73, height: 95))
        }
        videoCover2Img.snp.makeConstraints { make in
            make.leading.equalTo(videoCover1Img.snp.leading).offset(28)
            make.top.equalTo(videoCover1Img.snp.top).offset(10)
            make.size.equalTo(CGSize(width: 65, height: 85))
        }
        videoCover3Img.snp.makeConstraints { make in
            make.leading.equalTo(videoCover2Img.snp.leading).offset(33.5)
            make.top.equalTo(videoCover2Img.snp.top).offset(10)
            make.size.equalTo(CGSize(width: 50.5, height: 75))
        }
        videoNameLab.snp.makeConstraints { make in
            make.leading.equalTo(videoCover3Img.snp.trailing).offset(12)
            make.top.equalTo(19)
            make.trailing.equalToSuperview().inset(16)
        }
        arrowIcoImg.snp.makeConstraints { make in
            make.leading.equalTo(videoNameLab)
            make.bottom.equalTo(videoCover1Img)
            make.size.equalTo(12)
        }
        videoNumberLab.snp.makeConstraints { make in
            make.leading.equalTo(arrowIcoImg.snp.trailing).offset(4)
            make.centerY.equalTo(arrowIcoImg)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}