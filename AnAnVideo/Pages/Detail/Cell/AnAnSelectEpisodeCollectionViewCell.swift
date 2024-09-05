//
//  AnAnSelectEpisodeCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/23.
//

import UIKit

class AnAnSelectEpisodeCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"选集",fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangHeavyWithSize(fontSize: 17))
        return label
    }()
    private lazy var episodeBtn:ShowEpisodeViewBtn = {
        let btn = ShowEpisodeViewBtn(type: .custom)
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
        addSubview(titleLabel)
        addSubview(episodeBtn)
    }
    
    private func setSubviewsFrame() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(8)
            make.size.equalTo(CGSize(width: 34, height: 24))
        }
        episodeBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(CGSize(width: 100, height: 15))
        }
    }
    
    var dramaInfo:DramaInfoModel?{
        didSet{
            episodeBtn.introLabel.text = dramaInfo?.playStatus
        }
    }
}

fileprivate class ShowEpisodeViewBtn:UIButton{
    fileprivate lazy var introLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        label.textAlignment = .right
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
            make.size.equalTo(CGSize(width: 81, height: 15))
        }
        arrowIcon.snp.makeConstraints { make in
            make.leading.equalTo(introLabel.snp.trailing).offset(2)
            make.centerY.equalToSuperview()
            make.size.equalTo(12)
        }
    }
}
