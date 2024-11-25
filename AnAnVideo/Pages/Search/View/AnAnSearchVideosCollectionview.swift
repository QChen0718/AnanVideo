//
//  AnAnSearchVideosTableview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchVideosCollectionview: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        guard let flowlayout = layout as? UICollectionViewFlowLayout else { return  }
        flowlayout.minimumLineSpacing = 8
        flowlayout.itemSize = CGSize(width: AnAnAppDevice.an_screenWidth(), height: 65)
        delegate = self
        dataSource = self
        register(AnAnSearchVideoItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchVideoItemCollectionViewCell")
        contentInsetAdjustmentBehavior = .never
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataList:[AnAnMovieModel?] = []{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnSearchVideosCollectionview:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchVideoItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchVideoItemCollectionViewCell", for: indexPath) as! AnAnSearchVideoItemCollectionViewCell
        cell.seasonModel = dataList[indexPath.row]
        return cell
    }
}
