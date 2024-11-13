//
//  AnAnSearchHistoryKeyCollectionView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnSearchHistoryKeyCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        guard let flowlayout = layout as? UICollectionViewFlowLayout else { return }
        flowlayout.minimumLineSpacing = 12
        flowlayout.minimumInteritemSpacing = 12
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        delegate = self
        dataSource = self
        contentInsetAdjustmentBehavior = .never
        isScrollEnabled = false
        backgroundColor = .white
        register(AnAnSearchHistoryItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchHistoryItemCollectionViewCell")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnAnSearchHistoryKeyCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchHistoryItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchHistoryItemCollectionViewCell", for: indexPath) as! AnAnSearchHistoryItemCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.1, height: 30)
    }
    
}
