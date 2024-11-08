//
//  AnAnSettingBaseTableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/8.
//

import UIKit

class AnAnSettingBaseTableViewCell: UITableViewCell {

    lazy var titleLab:UILabel = {
       let lab = UILabel()
        lab.font = .systemFont(ofSize: 17, weight: .regular)
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        return lab
    }()
    
    lazy var arrowImg:UIImageView = {
       let img = UIImageView(image: UIImage(named: "ic_more"))
        return img
    }()
    
    lazy var lineView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_E6E7E8)
        return view
    }()
    
    var titleContentStr:String? {
        didSet{
            titleLab.text = titleContentStr
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(arrowImg)
        self.contentView.addSubview(lineView)
        titleLab.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
        arrowImg.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(12)
            make.centerY.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
