//
//  AnAnSearchCollectionview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/8.
//

import UIKit

class AnAnSearchCollectionview: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        let flowLayout:UICollectionViewFlowLayout = layout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 14.5
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        delegate = self
        dataSource = self
        backgroundColor = .white
        contentInsetAdjustmentBehavior = .never
        register(AnAnSearchItemCollectionViewCell.self, forCellWithReuseIdentifier: AnAnSearchItemCollectionViewCell.description())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var recommentVideoList:[AnanSearchRecommendDtos]?{
        didSet{
            self.reloadData()
        }
    }
}



extension AnAnSearchCollectionview:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommentVideoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnAnSearchItemCollectionViewCell.description(), for: indexPath) as! AnAnSearchItemCollectionViewCell
        cell.recomModel = self.recommentVideoList?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int((Float(AnAnAppDevice.an_screenWidth())-48)/3.0)
        return CGSizeMake(CGFloat(width), CGFloat(width*141/109) + 42)
    }
}
