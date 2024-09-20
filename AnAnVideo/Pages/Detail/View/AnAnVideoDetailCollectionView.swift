//
//  AnAnVideoDetailCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/18.
//

import UIKit

class AnAnVideoDetailCollectionView: UICollectionView {
    
    let anAnVideoInfoCollectionViewCellId = "AnAnVideoInfoCollectionViewCellId"
    let anAnSelectEpisodeCollectionViewCellId = "AnAnSelectEpisodeCollectionViewCellId"
    let anAnPeriodBgCollectionViewCellId = "AnAnPeriodBgCollectionViewCellId"
    let anAnEpisodeBgCollectionViewCellId = "AnAnEpisodeBgCollectionViewCellId"
    let anAnVideoActorCollectionViewCellId = "AnAnVideoActorCollectionViewCellId"
    let anAnHotSheetCollectionViewCellId = "AnAnHotSheetCollectionViewCellId"
    let anAnRecommentCollectionViewCellId = "AnAnRecommentCollectionViewCellId"
    
    var videoDetailModel:AnAnDetailModel?{
        didSet{
            self.reloadData()
        }
    }
    
    var seconDraayModel:SeconDarayModel?{
        didSet{
            self.reloadData()
        }
    }
    
    var dramaIntroModel:DramaIntroModel?{
        didSet{
            self.reloadData()
        }
    }
    
    var dramaModuleModel:DramaModuleModel?{
        didSet{
            self.reloadData()
        }
    }
    
    var recommendModel:RecommendListModel?{
        didSet{
            self.reloadData()
        }
    }
    
    init(frame:CGRect,collectionViewLayout layout: AnAnWaterFallFlowLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        layout.delegate = self
        self.delegate = self
        self.dataSource = self
        self.register(AnAnVideoInfoCollectionViewCell.self, forCellWithReuseIdentifier: anAnVideoInfoCollectionViewCellId)
        self.register(AnAnSelectEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: anAnSelectEpisodeCollectionViewCellId)
        self.register(AnAnPeriodBgCollectionViewCell.self, forCellWithReuseIdentifier: anAnPeriodBgCollectionViewCellId)
        self.register(AnAnEpisodeBgCollectionViewCell.self, forCellWithReuseIdentifier: anAnEpisodeBgCollectionViewCellId)
        self.register(AnAnVideoActorCollectionViewCell.self, forCellWithReuseIdentifier: anAnVideoActorCollectionViewCellId)
        self.register(AnAnHotSheetCollectionViewCell.self, forCellWithReuseIdentifier: anAnHotSheetCollectionViewCellId)
        self.register(AnAnRecommentCollectionViewCell.self, forCellWithReuseIdentifier: anAnRecommentCollectionViewCellId)
    }
    
    fileprivate var sectionArray:[String]{
        var array:[String] = [anAnVideoInfoCollectionViewCellId,anAnSelectEpisodeCollectionViewCellId]
        if let dramaSeriesList = seconDraayModel?.dramaSeriesList,dramaSeriesList.count > 0 {
            array.append(anAnPeriodBgCollectionViewCellId)
        }
        if let episodeList = videoDetailModel?.episodeList,episodeList.count > 0 {
            array.append(anAnEpisodeBgCollectionViewCellId)
        }
        
        if let moduleList = dramaModuleModel?.moduleList{
            moduleList.forEach { model in
                if model.moduleType == "ACTOR"{
//                    演员
                    if let actorList = model.actorList,actorList.count > 0 {
                        array.append(anAnVideoActorCollectionViewCellId)
                    }
                }
                if model.moduleType == "DRAMA_ALBUM"{
//                    专辑
                    if let dramaAlbumList = model.dramaAlbumList,dramaAlbumList.count>0{
                        array.append(anAnHotSheetCollectionViewCellId)
                    }
                }
            }
        }
        if let recommendList = recommendModel?.content, recommendList.count > 0{
            array.append(anAnRecommentCollectionViewCellId)
        }
        return array
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnAnVideoDetailCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionArray.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellType = sectionArray[section]
        if cellType == anAnRecommentCollectionViewCellId {
            return recommendModel?.content?.count ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = sectionArray[indexPath.section]
        if cellType == anAnVideoInfoCollectionViewCellId {
            let cell:AnAnVideoInfoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnVideoInfoCollectionViewCellId, for: indexPath) as! AnAnVideoInfoCollectionViewCell
            cell.dramaInfo = videoDetailModel?.dramaInfo
            cell.seconDarayModel = seconDraayModel
            return cell
        }else if cellType == anAnSelectEpisodeCollectionViewCellId {
            let cell:AnAnSelectEpisodeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnSelectEpisodeCollectionViewCellId, for: indexPath) as! AnAnSelectEpisodeCollectionViewCell
            cell.dramaInfo = videoDetailModel?.dramaInfo
            return cell
        }else if cellType == anAnPeriodBgCollectionViewCellId {
            let cell:AnAnPeriodBgCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnPeriodBgCollectionViewCellId, for: indexPath) as! AnAnPeriodBgCollectionViewCell
            cell.dramaSeriesList = seconDraayModel?.dramaSeriesList
            return cell
        }else if cellType == anAnEpisodeBgCollectionViewCellId {
            let cell:AnAnEpisodeBgCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnEpisodeBgCollectionViewCellId, for: indexPath) as! AnAnEpisodeBgCollectionViewCell
            cell.episodeList = videoDetailModel?.episodeList
            return cell
        }else if cellType == anAnVideoActorCollectionViewCellId {
            let cell:AnAnVideoActorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnVideoActorCollectionViewCellId, for: indexPath) as! AnAnVideoActorCollectionViewCell
            if let moduleList = dramaModuleModel?.moduleList{
                moduleList.forEach { model in
                    if model.moduleType == "ACTOR"{
                        cell.actorList = model.actorList
                        cell.moduleTitle = model.moduleTitle
                    }
                }
            }
            return cell
        }else if cellType == anAnHotSheetCollectionViewCellId {
            let cell:AnAnHotSheetCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnHotSheetCollectionViewCellId, for: indexPath) as! AnAnHotSheetCollectionViewCell
            if let moduleList = dramaModuleModel?.moduleList{
                moduleList.forEach { model in
                    if model.moduleType == "DRAMA_ALBUM"{
                        cell.dramaAlbumListModel = model.dramaAlbumList
                        cell.moduleTitle = model.moduleTitle
                    }
                }
            }
            return cell
        }else {
            let cell:AnAnRecommentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnRecommentCollectionViewCellId, for: indexPath) as! AnAnRecommentCollectionViewCell
            cell.contentModel = recommendModel?.content?[indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellType = sectionArray[indexPath.section]
        if cellType == anAnRecommentCollectionViewCellId {
//            推荐剧集
            guard let contentModel = recommendModel?.content?[indexPath.row] else { return }
            NotificationCenter.default.post(name: AnAnNotifacationName.SwitchSeaction, object: nil,userInfo: ["dramaId":contentModel.dramaId])
        }
    }
}

extension AnAnVideoDetailCollectionView:AnAnWaterFallFlowLayoutDelegate{
    
    func heightForRowAtIndexPath(collectionView collection: UICollectionView, layout: AnAnWaterFallFlowLayout, indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat {
        let cellType = sectionArray[indexPath.section]
        if cellType == anAnVideoInfoCollectionViewCellId{
            return 137
        }else if cellType == anAnSelectEpisodeCollectionViewCellId{
            return 41
        }else if cellType == anAnPeriodBgCollectionViewCellId {
            return 43
        }else if cellType == anAnEpisodeBgCollectionViewCellId {
            return 65
        }else if cellType == anAnVideoActorCollectionViewCellId {
            return 162
        }else if cellType == anAnHotSheetCollectionViewCellId {
            return 210
        }else {
            if let contentModel = recommendModel?.content?[indexPath.row]{
                if contentModel.topInfoTag?.title == nil {
                    return 272
                }else {
                    return 300
                }
            }
            return 272
        }
    }
    
    func columnNumber(collectionView collection: UICollectionView, layout: AnAnWaterFallFlowLayout, section: Int) -> Int {
        let cellType = sectionArray[section]
        if cellType == anAnRecommentCollectionViewCellId {
            return 2
        }
        return 1
    }
    
   
    func insetForSection(collectionView collection: UICollectionView, layout: AnAnWaterFallFlowLayout, section: Int) -> UIEdgeInsets {
        let cellType = sectionArray[section]
        if cellType == anAnRecommentCollectionViewCellId {
            return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        }
        return UIEdgeInsets.zero
    }
    
    func lineSpacing(collectionView collection: UICollectionView, layout: AnAnWaterFallFlowLayout, section: Int) -> CGFloat {
        let cellType = sectionArray[section]
        if cellType == anAnRecommentCollectionViewCellId {
            return 12
        }
        return 0
    }
    
    func interitemSpacing(collectionView collection: UICollectionView, layout: AnAnWaterFallFlowLayout, section: Int) -> CGFloat {
        let cellType = sectionArray[section]
        if cellType == anAnRecommentCollectionViewCellId {
            return 12
        }
        return 0
    }
    
}
