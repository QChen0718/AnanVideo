//
//  AnAnSearchCollectionview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/8.
//

import UIKit

class AnAnSearchCollectionview: UICollectionView {

    var hotList:[AnAnHotModel?] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        let flowLayout:UICollectionViewFlowLayout = layout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 14.5
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        delegate = self
        dataSource = self
        backgroundColor = .white
        contentInsetAdjustmentBehavior = .never
        register(AnAnSearchItemCollectionViewCell.self, forCellWithReuseIdentifier: AnAnSearchItemCollectionViewCell.description())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnSearchCollectionview {
    func loadSearchTopData() {
//        加载下一页数据
        AnAnRequest.shared.requestSearchTopListData(page: 1, rows: 20) { model in
            
        }
//        加载热门推荐数据
        AnAnRequest.shared.requestHotRecommendListData {[weak self] modelArray in
            guard let `self` else { return }
            self.hotList = modelArray
            self.reloadData()
        }
    }
}



extension AnAnSearchCollectionview:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hotList.first??.searchRecommendDtos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnAnSearchItemCollectionViewCell.description(), for: indexPath) as! AnAnSearchItemCollectionViewCell
        cell.recomModel = self.hotList.first??.searchRecommendDtos?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int((Float(AnAnAppDevice.an_screenWidth())-48)/3.0)
        return CGSizeMake(CGFloat(width), CGFloat(width*141/109) + 42)
    }
}
