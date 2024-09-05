//
//  AnAnPeriodBgCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/25.
//

import UIKit

class AnAnPeriodBgCollectionViewCell: UICollectionViewCell {
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 66, height: 31)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()
    private lazy var periodCollectionView:AnAnPeriodCollectionView = {
        let collectionView = AnAnPeriodCollectionView(frame: .zero, collectionViewLayout: viewLayout)
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
        contentView.addSubview(periodCollectionView)
    }
    
    private func setSubviewsFrame() {
        periodCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(-12)
        }
    }
    
    var dramaSeriesList:[DramaSeriesListModel]?{
        didSet{
            periodCollectionView.dramaSeriesList = dramaSeriesList
        }
    }
}
