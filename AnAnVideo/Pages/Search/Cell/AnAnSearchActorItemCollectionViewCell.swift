//
//  AnAnSearchActorItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchActorItemCollectionViewCell: UICollectionViewCell {
    
    lazy var userHeaderImg:UIImageView = {
       let img = UIImageView()
        img.layer.cornerRadius = 30
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var userNameLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_1890FF)
        lab.font = .systemFont(ofSize: 14, weight: .semibold)
        return lab
    }()
    
    lazy var userTagLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    lazy var lookUserVidesBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("查看作品", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_00A3FF)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(userHeaderImg)
        contentView.addSubview(userNameLab)
        contentView.addSubview(userTagLab)
        contentView.addSubview(lookUserVidesBtn)
        userHeaderImg.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(12)
            make.size.equalTo(60)
        }
        userNameLab.snp.makeConstraints { make in
            make.leading.equalTo(userHeaderImg.snp.trailing).offset(10)
            make.top.equalTo(userHeaderImg.snp.top).offset(13)
            make.trailing.equalToSuperview().inset(16)
        }
        userTagLab.snp.makeConstraints { make in
            make.leading.trailing.equalTo(userNameLab)
            make.top.equalTo(userNameLab.snp.bottom).offset(6.5)
        }
        lookUserVidesBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(CGSize(width: 80, height: 30))
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var actorModel:AnAnactorModel?{
        didSet{
            userHeaderImg.setImageWith(url: actorModel?.head_url ?? "")
            userNameLab.text = actorModel?.chinese_name
            userTagLab.text = "\(actorModel?.nationality ?? "")/\(actorModel?.birthday ?? "")"
        }
    }
}
