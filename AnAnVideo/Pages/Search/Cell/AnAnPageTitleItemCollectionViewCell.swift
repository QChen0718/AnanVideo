//
//  AnAnPageTitleItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnPageTitleItemCollectionViewCell: UICollectionViewCell {
    lazy var pageTitleLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
        lab.font = .systemFont(ofSize: 17, weight: .regular)
        return lab
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(pageTitleLab)
        pageTitleLab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(21)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var hotModel:AnAnHotModel?{
        didSet{
            pageTitleLab.text = hotModel?.hotRecommend
            if hotModel?.isSelect ?? false {
                pageTitleLab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
                pageTitleLab.font = .systemFont(ofSize: 17, weight: .semibold)
            }else{
                pageTitleLab.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
                pageTitleLab.font = .systemFont(ofSize: 17, weight: .regular)
            }
        }
    }
}
