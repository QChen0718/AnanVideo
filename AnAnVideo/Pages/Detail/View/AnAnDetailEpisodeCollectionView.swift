//
//  AnAnEpisodeCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/23.
//  选集

import UIKit

enum CollectionViewType {
    case CollectionViewEpisode
    case CollectionViewDownload
}

class AnAnDetailEpisodeCollectionView: UICollectionView {

    var episodeList:[EpisodeListModel]?{
        didSet{
            self.reloadData()
        }
    }
    
    
    fileprivate let anAnEpisodeItemCollectionViewCellId = "AnAnEpisodeItemCollectionViewCellId"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.showsHorizontalScrollIndicator = false
        self.register(AnAnEpisodeItemCollectionViewCell.self, forCellWithReuseIdentifier: anAnEpisodeItemCollectionViewCellId)
    }
    
    
    var currentSelectEpisode:Int = 0
    
    var collectionViewType:CollectionViewType = .CollectionViewEpisode
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnDetailEpisodeCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnEpisodeItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnEpisodeItemCollectionViewCellId, for: indexPath) as! AnAnEpisodeItemCollectionViewCell
        cell.episodeListModel = episodeList?[indexPath.row]
        if currentSelectEpisode == indexPath.row {
            cell.selectEpisode = true
        }else {
            cell.selectEpisode = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == currentSelectEpisode{
            return
        }
        currentSelectEpisode = indexPath.row
        if var model = episodeList?[indexPath.row] {
            if collectionViewType == .CollectionViewEpisode{
                NotificationCenter.default.post(name: AnAnNotifacationName.SwitchEpisode, object: nil,userInfo: ["episodeModel":model])
            }else {
//             获取下载地址，将下载地址pcdn转换成限速地址   发起下载请求，放入下载队列，还是等待队列
                NotificationCenter.default.post(name: AnAnNotifacationName.VideoDownloadInfo, object: nil,userInfo: ["episodeModel":model])
                model.isDownloading = true
                episodeList?[indexPath.row] = model
            }
        }
        self.reloadData()
    }
    
}
