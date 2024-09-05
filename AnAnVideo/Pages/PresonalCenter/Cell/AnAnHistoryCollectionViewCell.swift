//
//  AnAnHistoryCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/7.
//

import UIKit

class AnAnHistoryCollectionViewCell: UICollectionViewCell {
    private lazy var placeholderImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "img_me_history_empty")
        return imageView
    }()
    
    private lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    private lazy var historyCollectionView:AnAnHistoryCollectionView = {
        let view = AnAnHistoryCollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
        historyCollectionView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        self.contentView.addSubview(placeholderImageView)
        self.contentView.addSubview(historyCollectionView)
    }
    
    private func setSubviewsFrame() {
        placeholderImageView.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalToSuperview()
            make.height.equalTo(79)
        }
        
        historyCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
