//
//  AnAnShortVideoCollectionView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/6.
//

import UIKit

class AnAnShortVideoCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        let flowlayout = layout as! UICollectionViewFlowLayout
        flowlayout.minimumLineSpacing = 15
        flowlayout.minimumInteritemSpacing = 8
        flowlayout.itemSize = CGSize(width: (AnAnAppDevice.an_screenWidth()-48)/2, height: 138)
        delegate = self
        dataSource = self
        contentInsetAdjustmentBehavior = .never
        register(AnAnShortVideoCollectionViewCell.self, forCellWithReuseIdentifier: AnAnShortVideoCollectionViewCell.description())
        backgroundColor = .white
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sectionContentModels:[SectionContentModel]?{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnShortVideoCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnShortVideoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnAnShortVideoCollectionViewCell.description(), for: indexPath) as! AnAnShortVideoCollectionViewCell
        cell.sectionContentModel = sectionContentModels?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
