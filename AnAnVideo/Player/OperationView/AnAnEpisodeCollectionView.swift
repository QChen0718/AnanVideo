//
//  AnAnEpisodeView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//

import UIKit

// 将选择的剧集回调出去
typealias SelectEpisodeBlock = (EpisodeListModel?,Int)->Void

class AnAnEpisodeCollectionView: UICollectionView {

    private let anAnEpisodeCollectionViewCellId = "AnAnEpisodeCollectionViewCellId"
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        backgroundColor = .clear
        self.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 10, right: 30)
        self.register(AnAnEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: anAnEpisodeCollectionViewCellId)
    }
    
    var currentEpisode:Int = 0{
        didSet{
            self.reloadData()
        }
    }
    
    var episodeListArray:[EpisodeListModel]?{
        didSet{
            self.reloadData()
        }
    }
    var selectEpisodeBlock:SelectEpisodeBlock?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnEpisodeCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeListArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnEpisodeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnEpisodeCollectionViewCellId, for: indexPath) as! AnAnEpisodeCollectionViewCell
        if currentEpisode == indexPath.row{
            cell.isSelectIndex = true
        }else {
            cell.isSelectIndex = false
        }
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == currentEpisode {
            return
        }
        currentEpisode = indexPath.row
        selectEpisodeBlock!(episodeListArray?[indexPath.row],indexPath.row)
        self.reloadData()
    }
    
}
