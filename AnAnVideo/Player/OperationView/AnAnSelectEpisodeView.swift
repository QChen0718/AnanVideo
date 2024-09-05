//
//  AnAnSelectEpisodeView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//  选集view

import UIKit

// 将选择的剧集回调出去
typealias ReportCurrentEpisodeBlock = (EpisodeListModel?,Int)->Void

class AnAnSelectEpisodeView: UIView {
    
    var reportEpisodeBlock:ReportCurrentEpisodeBlock?
    
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 58, height: 58)
        return layout
    }()
    
//    选择剧集
    private lazy var episodeCollectionView:AnAnEpisodeCollectionView = {
        let view = AnAnEpisodeCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        view.selectEpisodeBlock = {[weak self] model,index in
            self?.reportEpisodeBlock!(model,index)
        }
        return view
    }()
    
    
    var episodeListArray:[EpisodeListModel]?{
        didSet{
            episodeCollectionView.episodeListArray = episodeListArray
        }
    }
    var currentPlayerIndex:Int = 0{
        didSet{
            episodeCollectionView.currentEpisode = currentPlayerIndex
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        addSubview(episodeCollectionView)
    }
    
    private func setSubviewsFrame() {
        episodeCollectionView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalTo(328)
        }
    }
}
