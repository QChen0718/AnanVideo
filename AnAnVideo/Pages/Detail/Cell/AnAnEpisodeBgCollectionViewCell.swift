//
//  AnAnEpisodeBgCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/25.
//

import UIKit

class AnAnEpisodeBgCollectionViewCell: UICollectionViewCell {
    
    var episodeList:[EpisodeListModel]?{
        didSet{
            episodeCollectionView.episodeList = episodeList
        }
    }
    
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 57, height: 57)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var episodeCollectionView:AnAnDetailEpisodeCollectionView = {
        let view = AnAnDetailEpisodeCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return view
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
        contentView.addSubview(episodeCollectionView)
    }
    
    private func setSubviewsFrame() {
        episodeCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(-8)
        }
    }
}
