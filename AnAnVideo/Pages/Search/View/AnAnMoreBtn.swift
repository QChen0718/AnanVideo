//
//  AnAnMoreBtn.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnMoreBtn: UIButton {

    lazy var moreLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        lab.textAlignment = .right
        return lab
    }()
    lazy var moreIcon:UIImageView = {
       let img = UIImageView(image: UIImage(named: ""))
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(moreLab)
        addSubview(moreIcon)
        moreLab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(moreIcon.snp.leading).offset(-4)
            make.leading.equalToSuperview()
        }
        moreIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
