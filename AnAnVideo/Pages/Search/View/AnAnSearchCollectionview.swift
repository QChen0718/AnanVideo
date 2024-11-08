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
        var flowLayout:UICollectionViewFlowLayout = layout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 14.5
        flowLayout.minimumInteritemSpacing = 8
        delegate = self
        dataSource = self
        backgroundColor = .white
        register(AnAnSearchItemCollectionViewCell.self, forCellWithReuseIdentifier: AnAnSearchItemCollectionViewCell.description())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnSearchCollectionview:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnAnSearchItemCollectionViewCell.description(), for: indexPath) as! AnAnSearchItemCollectionViewCell
        return cell
    }
}
