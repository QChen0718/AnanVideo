//
//  AnAnQualityTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//

import UIKit

class AnAnQualityTableViewCell: UITableViewCell {

    private lazy var qualityLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF)
        label.font = UIFont.pingFangSemiboldWithSize(fontSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var vipIconImg:UIImageView = {
        let img = UIImageView(image: UIImage(named: "ic_poster_corner_mark_vip"))
        return img
    }()
    
    lazy var loginBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"登录立享",target: self, action: #selector(openLoginPage))
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_216DFF)
        btn.layer.cornerRadius = 3
        btn.layer.masksToBounds = true
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        btn.titleLabel?.font = UIFont.pingFangMediumWithSize(fontSize: 12)
        return btn
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(qualityLabel)
        contentView.addSubview(loginBtn)
        contentView.addSubview(vipIconImg)
        vipIconImg.isHidden = true
    }
    
    private func setSubviewsFrame() {
        
//        横向时contentView宽度异常
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        qualityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.leading.equalTo(qualityLabel.snp.trailing).offset(4)
            make.centerY.equalTo(qualityLabel)
            make.height.equalTo(16)
        }
        vipIconImg.snp.makeConstraints { make in
            make.leading.equalTo(qualityLabel.snp.trailing).offset(4)
            make.centerY.equalTo(qualityLabel)
            make.size.equalTo(CGSize(width: 35, height: 16))
        }
        
    }
    
    var isSelectIndex:Bool = false{
        didSet{
            if isSelectIndex{
                qualityLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_216DFF)
                qualityLabel.font = UIFont.pingFangSemiboldWithSize(fontSize: 15)
            }else{
                qualityLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF)
                qualityLabel.font = UIFont.pingFangRegularWithSize(fontSize: 15)
            }
        }
    }
    var huaZhiInfoModel:SortedItemModel?{
        didSet{
            qualityLabel.text = huaZhiInfoModel?.qualityDescription
            if huaZhiInfoModel?.canShowVip == true {
                vipIconImg.isHidden = false
                loginBtn.isHidden = true
            }else{
                vipIconImg.isHidden = true
                if huaZhiInfoModel?.canPlay == true {
                    loginBtn.isHidden = true
                }else{
                    loginBtn.isHidden = false
                }
            }
        }
    }
    
    @objc func openLoginPage(){
        
    }
}
