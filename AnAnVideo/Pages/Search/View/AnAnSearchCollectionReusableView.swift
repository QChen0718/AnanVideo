//
//  AnAnSearchCollectionReusableView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchCollectionReusableView: UICollectionReusableView {
    
    lazy var sectionTitleLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 17, weight: .semibold)
        return lab
    }()
    
    lazy var moreBtn:AnAnMoreBtn = {
        let btn = AnAnMoreBtn(type: .custom)
        btn.addTarget(self, action: #selector(moreBtnClick), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionTitleLab)
        addSubview(moreBtn)
        sectionTitleLab.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.bottom.top.equalToSuperview()
            make.trailing.equalTo(moreBtn.snp.leading).offset(-10)
        }
        moreBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 140, height: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func moreBtnClick(){
        
    }
}
