//
//  AnAnSpeedTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2024/9/16.
//

import UIKit

class AnAnSpeedTableViewCell: UITableViewCell {

    fileprivate lazy var sppedLab:UILabel = {
       let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(sppedLab)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        sppedLab.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var speedModel:SpeedModel?{
        didSet{
            sppedLab.text = speedModel?.name
            if speedModel?.isSelect ?? false{
                sppedLab.textColor = UIColor.hexadecimalColor(hexadecimal: "#216DFF")
            }else{
                sppedLab.textColor = UIColor.hexadecimalColor(hexadecimal: "#FFFFFF")
            }
        }
    }
}
