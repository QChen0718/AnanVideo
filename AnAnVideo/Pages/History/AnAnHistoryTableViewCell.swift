//
//  AnAnHistoryTableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2025/1/21.
//

import UIKit

class AnAnHistoryTableViewCell: UITableViewCell {

    lazy var videoCover: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 17
        img.layer.masksToBounds = true
        img.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_E6E7E8)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var videoTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 15, weight: .regular)
        return lab
    }()
    
    lazy var videoProgressLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_84879A)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        contentView.addSubview(videoCover)
        contentView.addSubview(videoTitleLab)
        contentView.addSubview(videoProgressLab)
        videoCover.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 68))
        }
        
        videoTitleLab.snp.makeConstraints { make in
            make.top.equalTo(videoCover.snp.top).offset(11)
            make.leading.equalTo(videoCover.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(20)
        }
        
        videoProgressLab.snp.makeConstraints { make in
            make.leading.trailing.equalTo(videoTitleLab)
            make.top.equalTo(videoTitleLab.snp.bottom).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
