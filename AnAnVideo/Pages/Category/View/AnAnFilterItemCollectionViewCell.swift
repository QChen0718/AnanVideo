//
//  AnAnFilterItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnFilterItemCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_1890FF), font: UIFont.pingFangSemiboldWithSize(fontSize: 14))
        return label
    }()
    
    var filterName:String?{
        didSet{
            titleLabel.text = filterName
        }
    }
    var indexPath:IndexPath?{
        didSet{
            if indexPath?.row == 0{
                self.contentView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_1890FF,alpha: 0.1)
                self.contentView.layer.cornerRadius = 15
                self.titleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_1890FF)
                self.titleLabel.font = UIFont.pingFangSemiboldWithSize(fontSize: 14)
            }else{
                self.contentView.backgroundColor = .white
                self.titleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_454753)
                self.titleLabel.font = UIFont.pingFangRegularWithSize(fontSize: 14)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        self.contentView.addSubview(titleLabel)
    }
    
    private func setSubviewsFrame() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.trailing.equalTo(-14)
            make.top.equalTo(6.5)
            make.height.equalTo(17)
            make.bottom.equalTo(-6.5)
        }
    }
    
}
