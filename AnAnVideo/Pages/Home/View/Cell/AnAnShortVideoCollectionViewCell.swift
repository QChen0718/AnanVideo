//
//  AnAnShortVideoCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/6.
//

import UIKit

class AnAnShortVideoCollectionViewCell: UICollectionViewCell {
    
    private lazy var coverImg:UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 8
        img.layer.masksToBounds = true
        return img
    }()
    
    private lazy var nameLab:UILabel = {
       let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        label.font = UIFont.pingFangMediumWithSize(fontSize: 14)
        return label
    }()
    
    private lazy var movieDesLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_84879A)
        label.font = UIFont.pingFangRegularWithSize(fontSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(coverImg)
        self.contentView.addSubview(movieDesLabel)
        self.contentView.addSubview(nameLab)
        coverImg.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(94)
        }
        nameLab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(coverImg.snp.bottom).offset(10)
        }
        movieDesLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(nameLab.snp.bottom).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sectionContentModel:SectionContentModel?{
        didSet{
            coverImg.setImageWith(url: sectionContentModel?.icon ?? "")
            nameLab.text = sectionContentModel?.title ?? ""
            movieDesLabel.text = sectionContentModel?.subTitle ?? ""
        }
    }
}
