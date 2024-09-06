//
//  AnAnFilterCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnFilterCollectionViewCell: UICollectionViewCell {
    
    lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
//       item之间的间距为0时需要两个同时设置不然有问题
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    var typeTags:[AnAnFilterItemModel]?{
        didSet{
            filterCollectionView.typeTags = typeTags
        }
    }
    
    lazy var filterCollectionView:AnAnFilterCollectionView = {
        let collectionView = AnAnFilterCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.filterArray = ["全部","综艺","电视剧第三方","电影","脱口秀","纪录片"]
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
        self.contentView.addSubview(filterCollectionView)
    }
    
    private func setSubviewsFrame() {
        filterCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
