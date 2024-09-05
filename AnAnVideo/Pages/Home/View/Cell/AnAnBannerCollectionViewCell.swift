//
//  AnAnBannerCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/18.
//

import UIKit

class AnAnBannerCollectionViewCell: UICollectionViewCell {
    private lazy var coverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var movieName:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangSemiboldWithSize(fontSize: 17))
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    var bannerTopModel:BannerTopModel?{
        didSet{
            coverImageView.layoutIfNeeded()
            coverImageView.setImageWith(url: bannerTopModel?.imgUrl ?? "")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(coverImageView)
    }
    
    private func setSubviewsFrame() {
        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
