//
//  AnAnEpisodeSectionItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/13.
//

import UIKit

class AnAnEpisodeSectionItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var sectionTitleLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"1-48",fontColor: UIColor.hexadecimalColor(hexadecimal: An_1890FF), font: UIFont.pingFangSemiboldWithSize(fontSize: 15))
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(sectionTitleLabel)
        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(18)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
