//
//  AnAnSearchActorCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/20.
//

import UIKit

class AnAnSearchActorCollectionViewCell: UICollectionViewCell {
    
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
    
    lazy var videosLab:UILabel = {
       let lab = UILabel()
        lab.text = "作品集"
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 17, weight: .semibold)
        return lab
    }()
    
    lazy var moreBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("更多", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_85888F), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        return btn
    }()
    
    lazy var actorView:AnAnSearchActorCollectionview = {
        let view = AnAnSearchActorCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(userHeaderImg)
        contentView.addSubview(userNameLab)
        contentView.addSubview(userTagLab)
        contentView.addSubview(videosLab)
        contentView.addSubview(moreBtn)
        contentView.addSubview(actorView)
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
        videosLab.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(userHeaderImg.snp.bottom).offset(26)
        }
        moreBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(videosLab)
            make.size.equalTo(CGSize(width: 42, height: 20))
        }
        actorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(videosLab.snp.bottom).offset(10)
            make.height.equalTo(183)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var actorModels:[AnAnactorModel]?{
        didSet{
            guard let actorModel = actorModels?.first else { return }
            userHeaderImg.setImageWith(url: actorModel.headUrl ?? "")
            userNameLab.text = actorModel.chineseName
            userTagLab.text = "\(actorModel.nationality ?? "")/\(actorModel.birthday ?? "")"
            actorView.recommentDramaList = actorModel.relatedDramaList ?? []
        }
    }
}
