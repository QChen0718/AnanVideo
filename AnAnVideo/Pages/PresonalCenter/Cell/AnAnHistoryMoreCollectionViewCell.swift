//
//  AnAnHistoryMoreCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/9.
//

import UIKit

class AnAnHistoryMoreCollectionViewCell: UICollectionViewCell {
    
    private lazy var moreLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"查看\n更多",fontColor: UIColor.hexadecimalColor(hexadecimal: An_84879A,alpha: 0.6), font: UIFont.pingFangRegularWithSize(fontSize: 12),numberOfLines: 0)
        label.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_F2F4F8)
        return label
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
        self.contentView.addSubview(moreLabel)
    }
    
    private func setSubviewsFrame() {
        moreLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(79)
        }
    }
}
