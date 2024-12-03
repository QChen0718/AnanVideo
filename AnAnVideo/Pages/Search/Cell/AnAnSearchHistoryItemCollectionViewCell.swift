//
//  AnAnSearchHistoryItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnSearchHistoryItemCollectionViewCell: UICollectionViewCell {
    lazy var historyKeyLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_919699)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_F2F4F5)
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.addSubview(historyKeyLab)
        historyKeyLab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model:AnAnSearchLocalModel?{
        didSet{
            historyKeyLab.text = model?.searchContent
        }
    }
}
