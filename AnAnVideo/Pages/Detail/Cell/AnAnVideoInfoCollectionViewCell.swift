//
//  AnAnVideoInfoCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/18.
//

import UIKit

class AnAnVideoInfoCollectionViewCell: UICollectionViewCell {
    
    private lazy var movieNameLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangHeavyWithSize(fontSize: 20))
        return label
    }()
    
    private lazy var scoreLabel:UILabel = {
        
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private lazy var headerImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "user_header")
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var infoLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    private lazy var introBtn:IntroBtn = {
        let btn = IntroBtn(type: .custom)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.tag = 100
        return btn
    }()
    
    private lazy var likeBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"  追剧",image: UIImage(named: "ic_common_collect_big"),font: UIFont.pingFangRegularWithSize(fontSize: 12),fontColor:UIColor.hexadecimalColor(hexadecimal: An_222222) ,bgColor:UIColor.hexadecimalColor(hexadecimal: An_1890FF,alpha: 0.1),target:self,action: #selector(btnClick))
        btn.layer.cornerRadius = 8
        btn.tag = 200
        return btn
    }()
    
    private lazy var downloadBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_download"),target:self, action: #selector(btnClick))
        btn.tag = 300
        return btn
    }()
    
    private lazy var videoHallBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named:"ic_video_hall"),target:self,action: #selector(btnClick))
        btn.tag = 400
        return btn
    }()
    
    private lazy var shareBtn:UIButton = {
        let btn = AnAnButton.createButton(image: UIImage(named: "ic_juji_shareNoClickable"), target: self, action: #selector(btnClick))
        btn.tag = 500
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(headerImageView)
        contentView.addSubview(infoLabel)
        contentView.addSubview(introBtn)
        contentView.addSubview(likeBtn)
        contentView.addSubview(downloadBtn)
        contentView.addSubview(videoHallBtn)
        contentView.addSubview(shareBtn)
    }
    
    private func setSubviewsFrame() {
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(20)
            make.height.equalTo(24)
            make.trailing.equalTo(-60)
        }
        scoreLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.top.equalTo(24)
            make.size.equalTo(CGSize(width: 50, height: 15))
        }
        headerImageView.snp.makeConstraints { make in
            make.leading.equalTo(movieNameLabel)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(9.5)
            make.size.equalTo(12)
        }
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerImageView.snp.trailing).offset(3)
            make.centerY.equalTo(headerImageView)
            make.height.equalTo(15)
            make.trailing.equalTo(introBtn.snp.leading).offset(-15)
        }
        introBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.top.equalTo(scoreLabel.snp.bottom).offset(8)
            make.size.equalTo(CGSize(width: 41, height: 25))
        }
        likeBtn.snp.makeConstraints { make in
            make.leading.equalTo(movieNameLabel)
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 65, height: 30))
        }
        downloadBtn.snp.makeConstraints { make in
            make.trailing.equalTo(videoHallBtn.snp.leading).offset(-25)
            make.centerY.equalTo(likeBtn)
            make.size.equalTo(20)
        }
        videoHallBtn.snp.makeConstraints { make in
            make.trailing.equalTo(shareBtn.snp.leading).offset(-25)
            make.centerY.equalTo(likeBtn)
            make.size.equalTo(downloadBtn)
        }
        shareBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.centerY.equalTo(likeBtn)
            make.size.equalTo(downloadBtn)
        }
    }
    
    @objc fileprivate func btnClick(btn:UIButton){
        switch btn.tag {
        case 100:
            print("简介")
            break
        case 200:
            print("追剧")
            break
        case 300:
            NotificationCenter.default.post(name: AnAnNotifacationName.PopDownloadView, object: nil)
            print("下载")
            break
        case 400:
            print("放映厅")
            break
        case 500:
            print("分享")
            break
        default:
            break
        }
    }
    
    
    var dramaInfo:DramaInfoModel?{
        didSet{
            movieNameLabel.text = dramaInfo?.title
            let attributedStr = NSMutableAttributedString(string: String(format: "%.1f分",dramaInfo?.score ?? 0.0))
            attributedStr.addAttributes([NSAttributedString.Key.font:UIFont.bebasNeueRegularWithSize(fontSize: 19),NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_1890FF)], range: NSRange(location: 0, length: 3))
            attributedStr.addAttributes([NSAttributedString.Key.font:UIFont.bebasNeueRegularWithSize(fontSize: 12),NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_1890FF)], range: NSRange(location: 3, length: 1))
            scoreLabel.attributedText = attributedStr
        }
    }
    
    var seconDarayModel:SeconDarayModel?{
        didSet{
            headerImageView.setImageWith(url: seconDarayModel?.author?.headImgUrl ?? "")
            infoLabel.text = (seconDarayModel?.author?.nickName ?? "") + (seconDarayModel?.topInfo?.title ?? "")
        }
    }
}

fileprivate class IntroBtn:UIButton{
    private lazy var introLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"简介",fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    private lazy var arrowIcon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_more")
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        addSubview(introLabel)
        addSubview(arrowIcon)
    }
    
    private func setSubviewsFrame() {
        introLabel.snp.makeConstraints { make in
            make.leading.equalTo(5)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 15))
        }
        arrowIcon.snp.makeConstraints { make in
            make.leading.equalTo(introLabel.snp.trailing).offset(2)
            make.centerY.equalToSuperview()
            make.size.equalTo(12)
        }
    }
}
