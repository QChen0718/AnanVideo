//
//  AnAnHeaderView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/19.
//

import UIKit

class AnAnHeaderView: UIView {
    private lazy var movieCoverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var movieNameLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangSemiboldWithSize(fontSize: 20))
        return label
    }()
    private lazy var movieTagLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.8), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    private lazy var moreArrowIcon:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_universal_more_gray_8_24"),target:self,action: #selector(moreBtnClick))
        return btn
    }()
    private lazy var scoreBgView:ScoreView = {
        let view = ScoreView()
        return view
    }()
    private lazy var likeView:LikeView = {
        let view = LikeView()
        return view
    }()
    private lazy var seasonView:SelectSeasonView = {
        let view = SelectSeasonView()
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
//        movieCoverImageView.setImageWith(url: "http://img.jimihua.pro/img/img/20230208/o_48a866f6ca9d4b7d94de5c64163ca319.png")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        addSubview(movieCoverImageView)
        addSubview(movieNameLabel)
        addSubview(movieTagLabel)
        addSubview(moreArrowIcon)
        addSubview(scoreBgView)
        addSubview(likeView)
        addSubview(seasonView)
    }
    
    private func setSubviewsFrame() {
        movieCoverImageView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(AnAnAppDevice.deviceTop()+51)
            make.size.equalTo(CGSize(width: 100, height: 130))
        }
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieCoverImageView.snp.trailing).offset(16)
            make.top.equalTo(movieCoverImageView)
            make.trailing.equalTo(-16)
            make.height.equalTo(24)
        }
        movieTagLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieNameLabel)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(8)
            make.trailing.equalTo(-63)
            make.height.equalTo(15)
        }
        moreArrowIcon.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.centerY.equalTo(movieTagLabel)
            make.size.equalTo(CGSize(width: 48, height: 15))
        }
        scoreBgView.snp.makeConstraints { make in
            make.leading.equalTo(movieNameLabel)
            make.bottom.equalTo(movieCoverImageView)
            make.size.equalTo(CGSize(width: 65, height: 38))
        }
        likeView.snp.makeConstraints { make in
            make.leading.equalTo(scoreBgView.snp.trailing).offset(10)
            make.trailing.equalTo(-16)
            make.top.equalTo(scoreBgView)
            make.height.equalTo(38)
        }
        seasonView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(movieCoverImageView.snp.bottom).offset(16)
            make.height.equalTo(38)
        }
    }
}

extension AnAnHeaderView{
    @objc fileprivate func moreBtnClick(){
        
    }
}

fileprivate class ScoreView:UIView{
    private lazy var scoreLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"8.9",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.bebasNeueRegularWithSize(fontSize: 20))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var starView:StarView = {
        let view = StarView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.16)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        addSubview(scoreLabel)
        addSubview(starView)
    }
    
    private func setSubviewsFrame() {
        scoreLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(4)
            make.height.equalTo(20)
        }
        starView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom)
            make.height.equalTo(9)
        }
    }
}
// star
fileprivate class StarView:UIView{

    let starCount = 5
    override init(frame: CGRect) {
        super.init(frame: frame)
        createStar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createStar() {
        for i in 0..<starCount {
            let imageView = AnAnImageView.createImageView(name: "ic_home_star_n_white_18")
            addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.leading.equalTo(8+i*10)
                make.top.equalToSuperview()
                make.size.equalTo(CGSize(width: 9, height: 9))
            }
        }
    }
}
// 追剧
fileprivate class LikeView:UIButton{
    private lazy var likeIcon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_common_collect_h_28")
        return imageView
    }()
    private lazy var likeLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"想看",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 14))
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.16)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        addSubview(likeIcon)
        addSubview(likeLabel)
    }
    
    private func setSubviewsFrame() {
        likeIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-14)
            make.size.equalTo(CGSize(width: 13.3, height: 12.6))
        }
        likeLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeIcon.snp.trailing).offset(6)
            make.centerY.equalTo(likeIcon)
            make.trailing.equalTo(-16)
            make.height.equalTo(17)
        }
    }
}

// 季

fileprivate class SelectSeasonView:UIView{
    
    private lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 14))
        return label
    }()
    
    private lazy var infoLable:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.4), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    private lazy var seasonBtn:UIButton = {
        let btn = AnAnButton.createButton(title: "选季",image: UIImage(named: "ic_universal_more_gray_8_24"), target: self,action: #selector(seasonBtnClick))
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.16)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        addSubview(titleLabel)
//        addSubview(infoLable)
        addSubview(seasonBtn)
    }
    
    private func setSubviewsFrame() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
            make.trailing.equalTo(seasonBtn.snp.leading).offset(-10)
        }
        
        seasonBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 38, height: 38))
        }
    }
    
    @objc func seasonBtnClick(){
            
    }
}

