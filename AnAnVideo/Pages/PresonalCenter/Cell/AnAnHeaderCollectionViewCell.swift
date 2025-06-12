//
//  AnAnHeaderCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/7.
//

import UIKit
import Kingfisher

class AnAnHeaderCollectionViewCell: UICollectionViewCell {
    private lazy var bgImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "img_me_bg")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private lazy var headerImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "img_me_photo_n")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var statusLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"登录/注册",fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangSemiboldWithSize(fontSize: 20))
        return label
    }()
    private lazy var openLoginBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    private lazy var vipView:AnAnVipView = {
        let view = AnAnVipView(frame: .zero)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(vipBtnClick)))
        return view
    }()
    private lazy var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
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
        self.contentView.addSubview(bgImageView)
        self.bgImageView.addSubview(headerImageView)
        self.bgImageView.addSubview(statusLabel)
        self.bgImageView.addSubview(openLoginBtn)
        self.bgImageView.addSubview(vipView)
        self.bgImageView.addSubview(lineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineView.layoutIfNeeded()
        lineView.setConerTop(radius: 17)
    }
    private func setSubviewsFrame() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerImageView.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(AnAnAppDevice.statusBarHeight()+40)
            make.size.equalTo(40)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerImageView.snp.trailing).offset(16)
            make.centerY.equalTo(headerImageView)
            make.trailing.equalTo(-20)
            make.height.equalTo(24)
        }
        
        openLoginBtn.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        vipView.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(headerImageView.snp.bottom).offset(20)
            make.height.equalTo(72)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(18)
        }
    }
    
    public func updateData() {
        let model = AnAnUserData.readUserData()
        if AnAnUserData.isLogin {
            statusLabel.text = model?.user?.nickName
        }else{
            statusLabel.text = "登录/注册"
        }
        headerImageView.setImageWith(url: model?.user?.headImgUrl ?? "")
    }
    
    @objc func btnClick(){
        if !AnAnUserData.isLogin{
            AnAnJumpPageManager.goToLoginPage()
        }
    }
    
    @objc private func vipBtnClick(){
        AnAnJumpPageManager.goToVipPage()
    }
}
