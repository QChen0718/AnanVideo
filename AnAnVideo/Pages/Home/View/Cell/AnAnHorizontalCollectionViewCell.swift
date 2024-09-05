//
//  AnAnHorizontalCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/27.
//

import UIKit

class AnAnHorizontalCollectionViewCell: UICollectionViewCell {
    lazy var movieCoverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    lazy var movieNameLabel:UILabel = {
       let label = UILabel()
        label.text = "国庆献礼"
        label.font = UIFont.youSheBiaoRegularWithSize(fontSize: 25)
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF)
        label.textAlignment = .center
        return label
    }()
    
    lazy var movieDesLabel:UILabel = {
       let label = UILabel()
        label.text = "历史、主旋律"
        label.font = UIFont.pingFangRegularWithSize(fontSize: 11)
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.6)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(movieCoverImageView)
        self.movieCoverImageView.addSubview(movieNameLabel)
        self.movieCoverImageView.addSubview(movieDesLabel)
        movieCoverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        movieNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(movieDesLabel.snp.top).offset(-4)
            make.height.equalTo(25)
            make.leading.trailing.equalToSuperview()
        }
        movieDesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-12)
            make.height.equalTo(12)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sectionContentModel:SectionContentModel?{
        didSet{
            movieCoverImageView.layoutIfNeeded()
            movieCoverImageView.setImageWith(url: sectionContentModel?.coverUrl ?? "")
            movieNameLabel.text = sectionContentModel?.title ?? ""
            movieDesLabel.text = sectionContentModel?.subTitle ?? ""
        }
    }
}
