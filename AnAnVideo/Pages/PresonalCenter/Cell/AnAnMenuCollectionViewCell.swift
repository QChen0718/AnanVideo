//
//  AnAnMenuCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/7.
//

import UIKit

class AnAnMenuCollectionViewCell: UICollectionViewCell {
    private lazy var iconImageView:UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    private lazy var menulabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_F2F4F8)
        self.layer.cornerRadius = 17
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(menulabel)
    }
    
    private func setSubviewsFrame() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(40)
        }
        menulabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(0.5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(15)
        }
    }
    
    var ananPersonalModel:AnAnPersonalCenterModel?{
        didSet{
            iconImageView.image = UIImage(named: (ananPersonalModel?.iconImg)!)
            menulabel.text = ananPersonalModel?.titleLab
        }
    }
}
