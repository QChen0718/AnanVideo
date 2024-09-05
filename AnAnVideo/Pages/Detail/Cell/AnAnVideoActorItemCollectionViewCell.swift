//
//  AnAnVideoActorItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/26.
//

import UIKit

class AnAnVideoActorItemCollectionViewCell: UICollectionViewCell {
    private lazy var imagesArray:[UIImage] = {
        var array:[UIImage] = []
        for i in 0..<11{
            array.append(UIImage(named: "light_stick_\(i)")!)
        }
        return array
    }()
    private lazy var actorImageView:UIImageView = {
        let imageView = AnAnImageView()
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var actorNameLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var actorInfo:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var actorBgView:UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var starIconImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "light_stick_0")
        imageView.animationImages = imagesArray
        imageView.animationDuration = Double(imagesArray.count)*0.2
        imageView.startAnimating()
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        actorBgView.layoutIfNeeded()
        actorBgView.insertGradientColor(cornerRadius: 32.5, colors: [UIColor.hexadecimalColor(hexadecimal: An_1890FF).cgColor,UIColor.hexadecimalColor(hexadecimal: An_B17BFF).cgColor],startPoint: CGPoint(x: -0.34, y: 0.09),endPoint: CGPoint(x: 0.91, y: 0.91))
    }
    
    private func createSubviews() {
        contentView.addSubview(actorBgView)
        actorBgView.addSubview(actorImageView)
        actorBgView.addSubview(starIconImageView)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(actorInfo)
    }
    
    private func setSubviewsFrame() {
        actorBgView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(65)
        }
        actorImageView.snp.makeConstraints { make in
            make.leading.top.equalTo(2.5)
            make.trailing.equalTo(-2.5)
            make.height.equalTo(60)
        }
        starIconImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-2.5)
            make.bottom.equalTo(-2.5)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        actorNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(12)
            make.top.equalTo(actorImageView.snp.bottom).offset(8)
        }
        actorInfo.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(actorNameLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview()
        }
    }
    
    var actorListModel:ActorListModel?{
        didSet{
            actorNameLabel.text = actorListModel?.chineseName
            actorInfo.text = actorListModel?.roleName
//            actorImageView.setImageWith(url: actorListModel?.headUrl ?? "")
            starIconImageView.startAnimating()
        }
    }
}
