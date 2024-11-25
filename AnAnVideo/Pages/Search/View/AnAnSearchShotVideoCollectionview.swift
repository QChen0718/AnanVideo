//
//  AnAnSearchShotVideoViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchShotVideoCollectionview: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        guard let flowlayout = layout as? UICollectionViewFlowLayout else { return }
        flowlayout.minimumLineSpacing = 8
        flowlayout.minimumInteritemSpacing = 8
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowlayout.itemSize = CGSize(width: floor((AnAnAppDevice.an_screenWidth()-40)/2), height: 178)
        delegate = self
        dataSource = self
        register(AnAnSearchShortVideoItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchShortVideoItemCollectionViewCell")
        contentInsetAdjustmentBehavior = .never
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var dataList:[AnAnVideoModel?] = [] {
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnSearchShotVideoCollectionview:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchShortVideoItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchShortVideoItemCollectionViewCell", for: indexPath) as! AnAnSearchShortVideoItemCollectionViewCell
        cell.videoModel = dataList[indexPath.row]
        return cell
    }
}
