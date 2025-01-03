//
//  AnAnSearchResultTableview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchResultCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(AnAnSearchVideoItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchVideoItemCollectionViewCell")
        register(AnAnSearchPDCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchPDCollectionViewCell")
        register(AnAnSearchShortVideoItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchShortVideoItemCollectionViewCell")
        register(AnAnSearchActorCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchActorCollectionViewCell")
        register(AnAnSearchCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AnAnSearchCollectionReusableView")
        backgroundColor = .white
        contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataList:[[String:Any]] = []{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnSearchResultCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataList.count 
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let type:SearchResultType = dataList[section]["type"] as? SearchResultType else { return 0 }
        guard let array = dataList[section]["dataArray"] as? [Any] else { return 0}
        if type == SearchResultType.sheet {
            return 1
        }
        return array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let type:SearchResultType = dataList[indexPath.section]["type"] as? SearchResultType else { return UICollectionViewCell() }
        guard let array = dataList[indexPath.section]["dataArray"] as? [Any] else { return UICollectionViewCell()}
        if type == SearchResultType.season {
            let cell:AnAnSearchVideoItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchVideoItemCollectionViewCell", for: indexPath) as! AnAnSearchVideoItemCollectionViewCell
            cell.seasonModel = array[indexPath.row] as? AnAnMovieModel

            return cell
        }else if type == SearchResultType.sheet {
            let cell:AnAnSearchPDCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchPDCollectionViewCell", for: indexPath) as! AnAnSearchPDCollectionViewCell
            cell.pdcollection.pdList = array as? [AnAnSheetModel] ?? []
            return cell
        }
        else if type == SearchResultType.actor {
            let cell:AnAnSearchActorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchActorCollectionViewCell", for: indexPath) as! AnAnSearchActorCollectionViewCell
            cell.actorModels = array as? [AnAnactorModel]
            return cell
        }
        else{
            let cell:AnAnSearchShortVideoItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchShortVideoItemCollectionViewCell", for: indexPath) as! AnAnSearchShortVideoItemCollectionViewCell
            cell.videoModel = array[indexPath.row] as? AnAnVideoModel
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let type:SearchResultType = dataList[indexPath.section]["type"] as? SearchResultType else { return .zero }
        if type == SearchResultType.season {
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 65)
        }else if type == SearchResultType.sheet {
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 127)
        }else if type == SearchResultType.actor {
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 320)
        }else{
            return CGSize(width: floor((AnAnAppDevice.an_screenWidth()-40)/2), height: 178)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 51)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let type:SearchResultType = dataList[indexPath.section]["type"] as? SearchResultType else { return UICollectionReusableView() }
        if kind == UICollectionView.elementKindSectionHeader {
            let headerResusa:AnAnSearchCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AnAnSearchCollectionReusableView", for: indexPath) as! AnAnSearchCollectionReusableView
            if type == SearchResultType.season {
                headerResusa.sectionTitleLab.text = "影视"
            }else if type == SearchResultType.actor {
                headerResusa.sectionTitleLab.text = "明星"
            }else if type == SearchResultType.sheet {
                headerResusa.sectionTitleLab.text = "片单"
            }else{
                headerResusa.sectionTitleLab.text = "快看"
            }
            return headerResusa
        }
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let type:SearchResultType = dataList[section]["type"] as? SearchResultType else { return .zero }
        if type == SearchResultType.video {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let type:SearchResultType = dataList[section]["type"] as? SearchResultType else { return .zero }
        if type == SearchResultType.video {
            return 8
        }
        if type == SearchResultType.season {
            return 8
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let type:SearchResultType = dataList[section]["type"] as? SearchResultType else { return .zero }
        if type == SearchResultType.video {
            return 8
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type:SearchResultType = dataList[indexPath.section]["type"] as? SearchResultType else { return }
        guard let array = dataList[indexPath.section]["dataArray"] as? [Any] else { return }
        switch type {
        case .season:
           let model = array[indexPath.row] as? AnAnMovieModel
            AnAnJumpPageManager.gotToDetailPage(dramaId: model?.id ?? "")
            break
        case .actor:
            break
        case .sheet:
            break
        case .video:
            break
        }
    }
}
