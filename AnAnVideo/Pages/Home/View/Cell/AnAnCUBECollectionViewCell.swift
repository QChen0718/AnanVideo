//
//  AnAnCUBECollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/5.
//

import UIKit

class AnAnCUBECollectionViewCell: UICollectionViewCell {
    
    lazy var iconImg:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var titleLab:UILabel = {
       let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_84879A)
        label.font = UIFont.pingFangRegularWithSize(fontSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(iconImg)
        self.contentView.addSubview(titleLab)
        iconImg.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.contentView)
            make.height.equalTo(35)
        }
        titleLab.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.contentView)
            make.top.equalTo(iconImg.snp.bottom).offset(6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sectionContentModel:SectionContentModel?{
        didSet{
            iconImg.layoutIfNeeded()
            iconImg.setImageWith(url: sectionContentModel?.icon ?? "")
            titleLab.text = sectionContentModel?.title
        }
    }
}
