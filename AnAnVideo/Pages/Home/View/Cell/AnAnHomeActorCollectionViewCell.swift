//
//  AnAnHomeActorCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/17.
//

import UIKit

class AnAnHomeActorCollectionViewCell: UICollectionViewCell {
    private lazy var actorImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    private lazy var titleBgView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_222222,alpha: 0.5)
        return view
    }()
    private lazy var actorName:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(actorImageView)
        actorImageView.addSubview(titleBgView)
        titleBgView.addSubview(actorName)
    }
    
    private func setSubviewsFrame() {
        actorImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleBgView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
        actorName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    var sectionContentModel:SectionContentModel?{
        didSet{
            actorImageView.layoutIfNeeded()
            actorImageView.setImageWith(url: sectionContentModel?.icon ?? "")
            actorName.text = sectionContentModel?.title
        }
    }
}
