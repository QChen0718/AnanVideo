//
//  AnAnEpisodeCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//

import UIKit

class AnAnEpisodeCollectionViewCell: UICollectionViewCell {
    
    private lazy var numberLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.4)
        label.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.15)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(numberLabel)
    }
    
    private func setSubviewsFrame() {
        numberLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    var isSelectIndex:Bool = false{
        didSet{
            if isSelectIndex{
                contentView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_0091FF)
            }else{
                contentView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.15)
            }
        }
    }
    
    var indexPath:IndexPath?{
        didSet{
            numberLabel.text = String(indexPath!.row + 1)
        }
    }
}
