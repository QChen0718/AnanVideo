//
//  AnAnCategoryCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

enum CellType:String {
  case CellTypeMovieStatus = "sort"  //状态
  case CellTypeMovieYear    //年份
  case CellTypeMovieNationality = "area" //国籍
  case CellTypeMoviePlot    //剧情
  case CellTypeMovieClass = "dramaType" //类别
  case CellTypeMovieUpdate // 播放
  case CellTypeMovieisFree //是否收费
  case CellTypeSpread   //展开或收起
  case CellTypeCategoryItem //电影
}

class AnAnCategoryCollectionView: UICollectionView {
    
    let anAnFilterCollectionViewCellId = "anAnFilterCollectionViewCellId"
    let anAnSpreadCollectionViewCellId = "anAnSpreadCollectionViewCellId"
    let anAnCategoryItemCollectionViewCellId = "anAnCategoryItemCollectionViewCellId"
    let filterViewHeight = 210
    var sectionArray:[CellType] = []
    var tagsArray:[AnAnFilterModel?]? {
        didSet{
            self.reloadData()
        }
    }
    lazy var zsectionArray:[CellType] = {
        let array = [addSectionType(cellType: .CellTypeMovieStatus),addSectionType(cellType: .CellTypeMovieYear),addSectionType(cellType: .CellTypeMovieNationality),addSectionType(cellType: .CellTypeMoviePlot),addSectionType(cellType: .CellTypeSpread),addSectionType(cellType: .CellTypeCategoryItem)]
        return array
    }()
    
    lazy var ssectionArray:[CellType] = {
        let array = [addSectionType(cellType: .CellTypeMovieStatus),addSectionType(cellType: .CellTypeMovieYear),addSectionType(cellType: .CellTypeMovieNationality),addSectionType(cellType: .CellTypeMoviePlot),addSectionType(cellType: .CellTypeMovieClass),addSectionType(cellType: .CellTypeMovieUpdate),addSectionType(cellType: .CellTypeMovieisFree),addSectionType(cellType: .CellTypeSpread),addSectionType(cellType: .CellTypeCategoryItem)]
        return array
    }()
    
    private func addSectionType(cellType:CellType) -> CellType {
        return cellType
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
//        sectionArray = zsectionArray
        self.register(AnAnFilterCollectionViewCell.self, forCellWithReuseIdentifier: anAnFilterCollectionViewCellId)
        self.register(AnAnSpreadCollectionViewCell.self, forCellWithReuseIdentifier: anAnSpreadCollectionViewCellId)
        self.register(AnAnCategoryItemCollectionViewCell.self, forCellWithReuseIdentifier: anAnCategoryItemCollectionViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnCategoryCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tagsArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let type:CellType = sectionArray[section]
//        switch type {
//            case .CellTypeCategoryItem:
//                return 19
//            default:
                return 1
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let type:CellType = sectionArray[indexPath.section]
//        if type == .CellTypeSpread{
//            let cell:AnAnSpreadCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnSpreadCollectionViewCellId, for: indexPath) as! AnAnSpreadCollectionViewCell
//            return cell
//        }else if type == .CellTypeCategoryItem{
//            let cell:AnAnCategoryItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnCategoryItemCollectionViewCellId, for: indexPath) as! AnAnCategoryItemCollectionViewCell
//            return cell
//        }else {
            let cell:AnAnFilterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnFilterCollectionViewCellId, for: indexPath) as! AnAnFilterCollectionViewCell
            cell.typeTags = tagsArray?[indexPath.section]?.dramaFilterItemList
            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let type:CellType = sectionArray[indexPath.section]
//        if type == .CellTypeSpread {
//            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 28)
//        }else if type == .CellTypeCategoryItem {
//            let width:CGFloat = (AnAnAppDevice.an_screenWidth()-60)/3.0
//            return CGSize(width: width, height: width * 183/105)
//        }else {
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 30)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let type:CellType = sectionArray[section]
//        if type == .CellTypeCategoryItem{
//            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 14)
//        }else if type == .CellTypeSpread{
//            return CGSize.zero
//        }
//        else{
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 12)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        let type:CellType = sectionArray[section]
//        if type == .CellTypeCategoryItem{
//            return 15.5
//        }else{
            return 0
//        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        let type:CellType = sectionArray[section]
//        if type == .CellTypeCategoryItem{
//            return 10
//        }else{
            return 0
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let type:CellType = sectionArray[section]
//        if type == .CellTypeCategoryItem{
//            return UIEdgeInsets(top: 0, left: 20, bottom: 12, right: 20)
//        }else{
            return UIEdgeInsets.zero
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type:CellType = sectionArray[indexPath.section]
        if type == .CellTypeSpread{
            if sectionArray.count == 6 {
                sectionArray = ssectionArray
            }else{
                sectionArray = zsectionArray
            }
            
            self.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("offset->\(scrollView.contentOffset.y)")
//        滑动到指定位置显示浮层
        if scrollView.contentOffset.y >= 210{
//            显示浮层
        }else{
            
        }
    }
}
