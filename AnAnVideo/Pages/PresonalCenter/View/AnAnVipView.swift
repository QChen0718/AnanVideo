//
//  AnAnVipView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/7.
//

import UIKit

class AnAnVipView: UIView {
    private lazy var bgImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "img_me_vipcard_n")
        return imageView
    }()
    private lazy var vipIcon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_me_vipcard_vip_n")
        return imageView
    }()
    private lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"多多视频会员",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangSemiboldWithSize(fontSize: 17))
        return label
    }()
    private lazy var openVipLabel:UIButton = {
        let btn = AnAnButton.createButton(title: "立即开通",font: UIFont.pingFangSemiboldWithSize(fontSize: 14),fontColor: UIColor.hexadecimalColor(hexadecimal: An_715832),target:self,action: #selector(btnClick))
        return btn
    }()
    private lazy var descLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"尊享12项专属看剧特权",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 11))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        openVipLabel.layoutIfNeeded()
        openVipLabel.insertGradientColor(cornerRadius: 17, colors: [UIColor.hexadecimalColor(hexadecimal: An_FAE1A9).cgColor,UIColor.hexadecimalColor(hexadecimal: An_F0CF88).cgColor])
//        openVipLabel.backgroundColor = UIColor(patternImage: getGradientImage(size: openVipLabel.bounds.size,colors: [UIColor.hexadecimalColor(hexadecimal: An_FAE1A9).cgColor,UIColor.hexadecimalColor(hexadecimal: An_F0CF88).cgColor]))
    }
    
    private func createSubviews() {
        self.addSubview(bgImageView)
        bgImageView.addSubview(vipIcon)
        bgImageView.addSubview(titleLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(openVipLabel)
    }
    
    private func setSubviewsFrame() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        vipIcon.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(18)
            make.size.equalTo(CGSize(width: 48.5, height: 16))
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(vipIcon.snp.trailing).offset(4)
            make.trailing.equalTo(openVipLabel.snp.leading).offset(-10)
            make.centerY.equalTo(vipIcon)
            make.height.equalTo(21)
        }
        openVipLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bgImageView)
            make.trailing.equalTo(-16)
            make.size.equalTo(CGSize(width: 88, height: 40))
        }
        descLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.bottom.equalTo(-14)
            make.trailing.equalTo(titleLabel)
            make.height.equalTo(11)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   @objc func btnClick() {
        
    }
}
