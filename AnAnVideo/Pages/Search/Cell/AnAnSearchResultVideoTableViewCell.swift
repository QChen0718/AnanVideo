//
//  AnAnSearchResultVideoTableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnSearchResultVideoTableViewCell: AnAnSearchResultNameTableViewCell {

    lazy var videoCoverImg: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .lightGray
        img.layer.cornerRadius = 12
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var videoTagLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    lazy var videoActorLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(videoCoverImg)
        contentView.addSubview(videoTagLab)
        contentView.addSubview(videoActorLab)
        videoCoverImg.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 65))
        }
        videoNameLab.snp.remakeConstraints { make in
            make.leading.equalTo(videoCoverImg.snp.trailing).offset(10)
            make.top.equalTo(videoCoverImg.snp.top).offset(5)
            make.trailing.equalToSuperview().inset(16)
        }
        videoTagLab.snp.makeConstraints { make in
            make.leading.trailing.equalTo(videoNameLab)
            make.top.equalTo(videoNameLab.snp.bottom).offset(8)
        }
        videoActorLab.snp.makeConstraints { make in
            make.leading.trailing.equalTo(videoNameLab)
            make.top.equalTo(videoTagLab.snp.bottom).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
