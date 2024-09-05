//
//  AnAnMorePhotoCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/27.
//

import UIKit

class AnAnMorePhotoCollectionViewCell: UICollectionViewCell {
    private lazy var movieCoverImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 17
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var vipIconImageView:UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "ic_vip_corner_mark"))
        return imageView
    }()
    
    private lazy var movieNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        label.font = UIFont.pingFangMediumWithSize(fontSize: 14)
        return label
    }()
    
    private lazy var movieDesLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_84879A)
        label.font = UIFont.pingFangRegularWithSize(fontSize: 12)
        return label
    }()
    
    var sectionContentModel:SectionContentModel?{
        didSet{
            movieCoverImageView.layoutIfNeeded()
            movieCoverImageView.setImageWith(url: sectionContentModel?.coverUrl ?? "")
            movieNameLabel.text = sectionContentModel?.title ?? ""
            movieDesLabel.text = sectionContentModel?.subTitle ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(movieCoverImageView)
        self.movieCoverImageView.addSubview(vipIconImageView)
        self.contentView.addSubview(movieDesLabel)
        self.contentView.addSubview(movieNameLabel)
        setSubviewsFrame()
    }
    
    func setSubviewsFrame() {
        movieCoverImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(136.5)
        }
        vipIconImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: 38.5, height: 20))
        }
        movieNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(movieCoverImageView.snp.bottom).offset(10)
            make.height.equalTo(17)
        }
        movieDesLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.movieNameLabel.snp.bottom).offset(4)
            make.height.equalTo(15)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
