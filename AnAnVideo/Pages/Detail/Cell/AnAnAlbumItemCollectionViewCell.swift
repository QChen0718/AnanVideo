//
//  AnAnAlbumItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/26.
//

import UIKit

class AnAnAlbumItemCollectionViewCell: UICollectionViewCell {
    private lazy var bgImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "sheet_bkg_img")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var movieCoverImageView:UIImageView = {
        let imageView = AnAnImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var movieCoverImageView2:UIImageView = {
        let imageView = AnAnImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    private lazy var movieCoverImageView3:UIImageView = {
        let imageView = AnAnImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        return imageView
    }()
    private lazy var movieNameLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangSemiboldWithSize(fontSize: 14))
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(movieCoverImageView3)
        bgImageView.addSubview(movieCoverImageView2)
        bgImageView.addSubview(movieCoverImageView)
        bgImageView.addSubview(movieNameLabel)
    }
    
    private func setSubviewsFrame() {
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        movieCoverImageView.snp.makeConstraints { make in
            make.leading.equalTo(12.5)
            make.top.equalTo(17)
            make.size.equalTo(CGSize(width: 73, height: 95.5))
        }
        movieCoverImageView2.snp.makeConstraints { make in
            make.leading.equalTo(54.5)
            make.size.equalTo(CGSize(width: 62, height: 85))
            make.bottom.equalTo(movieCoverImageView)
        }
        movieCoverImageView3.snp.makeConstraints { make in
            make.trailing.equalTo(-12.5)
            make.top.equalTo(37.5)
            make.size.equalTo(CGSize(width: 58, height: 75))
            make.bottom.equalTo(movieCoverImageView)
        }
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(12.5)
            make.trailing.equalTo(-12.5)
            make.top.equalTo(movieCoverImageView.snp.bottom).offset(11)
            make.height.equalTo(20)
        }
    }
    
    var dramaAlbumModel:DramaAlbumListModel?{
        didSet{
            if let images = dramaAlbumModel?.images,images.count>2{
                movieCoverImageView.setImageWith(url: images[0])
                movieCoverImageView2.setImageWith(url: images[1])
                movieCoverImageView3.setImageWith(url: images[2])
            }
            movieNameLabel.text = dramaAlbumModel?.name
            contentView.backgroundColor = UIColor.hexadecimalColor(hexadecimal: dramaAlbumModel?.color ?? An_66474F)
        }
    }
}
