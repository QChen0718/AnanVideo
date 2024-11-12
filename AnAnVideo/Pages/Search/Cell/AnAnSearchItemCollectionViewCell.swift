//
//  AnAnSearchItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/8.
//

import UIKit

class AnAnSearchItemCollectionViewCell: UICollectionViewCell {
    
    lazy var videoCoverImg:UIImageView = {
       let img = UIImageView()
        img.backgroundColor = .lightGray
        img.layer.cornerRadius = 8
        img.layer.masksToBounds = true
        return img
    }()
    
    lazy var topNumImg:UIImageView = {
       let img = UIImageView()
        return img
    }()
    
    lazy var topNumLab:UILabel = {
       let lab = UILabel()
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 14, weight: .bold)
        return lab
    }()
    
    lazy var pfLabl:UILabel = {
       let lab = UILabel()
        lab.font = .systemFont(ofSize: 17, weight: .regular)
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.8007)
        lab.textAlignment = .right
        return lab
    }()
    
    lazy var videoNameLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 14, weight: .regular)
        return lab
    }()
    
    lazy var videoSubnameLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(videoCoverImg)
        videoCoverImg.addSubview(topNumImg)
        topNumImg.addSubview(topNumLab)
        videoCoverImg.addSubview(pfLabl)
        contentView.addSubview(videoNameLab)
        contentView.addSubview(videoSubnameLab)
        videoCoverImg.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(self.mj_size.height - 42)
        }
        topNumImg.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.size.equalTo(20)
        }
        
        topNumLab.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        pfLabl.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(2)
            make.leading.equalToSuperview()
        }
        
        videoNameLab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(videoCoverImg.snp.bottom).offset(8.5)
        }
        
        videoSubnameLab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(videoNameLab.snp.bottom).offset(3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var recomModel:AnanSearchRecommendDtos?{
        didSet{
            videoCoverImg.setImageWith(url: recomModel?.picUrl ?? "")
            pfLabl.text = recomModel?.score
            videoNameLab.text = recomModel?.title
            videoSubnameLab.text = recomModel?.subtitle
        }
    }
}
