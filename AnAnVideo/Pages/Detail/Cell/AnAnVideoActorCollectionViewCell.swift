//
//  AnAnVideoActorCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/23.
//  演员

import UIKit

class AnAnVideoActorCollectionViewCell: UICollectionViewCell {
    
    private lazy var actorLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_242424), font: UIFont.pingFangSemiboldWithSize(fontSize: 17))
        return label
    }()
    
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 65, height: 101)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var actorCollectionView:AnAnVideoActorCollectionView = {
        let collectionView = AnAnVideoActorCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
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
        contentView.addSubview(actorLabel)
        contentView.addSubview(actorCollectionView)
    }
    
    private func setSubviewsFrame() {
        actorLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalToSuperview()
            make.height.equalTo(21)
        }
        actorCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(actorLabel.snp.bottom).offset(12)
            make.bottom.equalTo(-28)
        }
    }
    
    var actorList:[ActorListModel]?{
        didSet{
            actorCollectionView.actorList = actorList
        }
    }
    var moduleTitle:String?{
        didSet{
            actorLabel.text = moduleTitle
        }
    }
}
