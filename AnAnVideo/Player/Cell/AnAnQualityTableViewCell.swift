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
        label.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
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
    }
    
    var isSelectIndex:Bool = false{
        didSet{
            if isSelectIndex{
                qualityLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_F75C94)
            }else{
                qualityLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF)
            }
        }
    }
    var huaZhiInfoModel:SortedItemModel?{
        didSet{
            qualityLabel.text = huaZhiInfoModel?.qualityDescription
        }
    }
}
