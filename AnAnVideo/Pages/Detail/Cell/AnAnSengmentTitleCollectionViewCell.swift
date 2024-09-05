//
//  AnAnSengmentTitleCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/21.
//

import UIKit

class AnAnSengmentTitleCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 17))
        return label
    }()
    
    private lazy var lineView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1.5
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var subTitleLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_88898F), font: UIFont.pingFangRegularWithSize(fontSize: 10))
        return label
    }()
    
    private lazy var titleImage:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "detail_pic_comments_blue_28")
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
        titleImage.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineView.layoutIfNeeded()
        lineView.insertGradientColor(cornerRadius: 1.5, colors: [UIColor.hexadecimalColor(hexadecimal: An_00BBFF).cgColor,UIColor.hexadecimalColor(hexadecimal: An_1890FF).cgColor],startPoint: CGPoint(x: -0.23, y: 0.12),endPoint: CGPoint(x: 0.9, y: 0.9))
    }
    
    private func createSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleImage)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(lineView)
    }
    
    private func setSubviewsFrame() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(12.5)
            make.height.equalTo(21)
            make.bottom.equalTo(lineView.snp.top).offset(-10)
        }
//        titleImage.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.size.equalTo(CGSize(width: 30, height: 14))
//        }
//        subTitleLabel.snp.makeConstraints { make in
//            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.height.equalTo(10)
//        }
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 10, height: 3))
        }
    }
    
    var titleStr:String?{
        didSet{
            titleLabel.text = titleStr
        }
    }
    
    var isSelectSegmentTitle:Bool?{
        didSet{
            if let currentSelect = isSelectSegmentTitle, currentSelect {
//                选中
                titleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
                titleLabel.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
                lineView.isHidden = false
            }else{
//                未选中
                titleLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_85888F)
                titleLabel.font = UIFont.pingFangRegularWithSize(fontSize: 17)
                lineView.isHidden = true
            }
        }
    }
}
