//
//  AnAnDownloadSuccessTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/5/18.
//

import UIKit

class AnAnDownloadSuccessTableViewCell: UITableViewCell {

    private lazy var movieCoverImageView:UIImageView = {
        let imageView = AnAnImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var movieName:UILabel = {
        let label = AnAnLabel.createLabel(text:"花束般的恋爱",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 14))
        return label
    }()
    
    private lazy var movieInfo:UILabel = {
        let label = AnAnLabel.createLabel(text: "日本 / 45.1M",fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    private lazy var movieEpisode:UILabel = {
        let label = AnAnLabel.createLabel(text: "已缓存 2 集（共 12 集）",fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    private lazy var lookDownloadBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"查看下载",font: UIFont.pingFangRegularWithSize(fontSize: 12),fontColor: UIColor.hexadecimalColor(hexadecimal: An_EBEBF5),target: self, action: #selector(btnClick))
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.32).cgColor
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()
    
    private lazy var dramaDetailBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"剧集详情",font: UIFont.pingFangRegularWithSize(fontSize: 12),fontColor: UIColor.hexadecimalColor(hexadecimal: An_EBEBF5),target: self, action: #selector(btnClick))
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.32).cgColor
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(movieCoverImageView)
        contentView.addSubview(movieName)
        contentView.addSubview(movieInfo)
        contentView.addSubview(movieEpisode)
        contentView.addSubview(lookDownloadBtn)
        contentView.addSubview(dramaDetailBtn)
    }
    
    private func setSubviewsFrame() {
        movieCoverImageView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(20)
            make.size.equalTo(CGSize(width: 80, height: 104))
        }
        movieName.snp.makeConstraints { make in
            make.leading.equalTo(movieCoverImageView.snp.trailing).offset(12)
            make.top.equalTo(movieCoverImageView.snp.top).offset(2)
            make.height.equalTo(14)
            make.trailing.equalTo(-20)
        }
        movieInfo.snp.makeConstraints { make in
            make.leading.trailing.equalTo(movieName)
            make.top.equalTo(movieName.snp.bottom).offset(12)
            make.height.equalTo(12)
        }
        movieEpisode.snp.makeConstraints { make in
            make.leading.trailing.equalTo(movieName)
            make.top.equalTo(movieInfo.snp.bottom).offset(12)
            make.height.equalTo(12)
        }
        lookDownloadBtn.snp.makeConstraints { make in
            make.leading.equalTo(movieName)
            make.top.equalTo(movieEpisode.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 68, height: 25))
        }
        dramaDetailBtn.snp.makeConstraints { make in
            make.leading.equalTo(lookDownloadBtn.snp.trailing).offset(8)
            make.top.size.equalTo(lookDownloadBtn)
        }
    }
    
    
    @objc private func btnClick(){
        
    }
}
