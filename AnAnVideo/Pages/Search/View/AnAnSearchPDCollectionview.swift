//
//  AnAnSearchPDCollectionview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchPDCollectionview: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        guard let flowlayout = layout as? UICollectionViewFlowLayout else { return }
        flowlayout.minimumLineSpacing = 8
        flowlayout.minimumInteritemSpacing = 8
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowlayout.scrollDirection = .horizontal
        flowlayout.itemSize = CGSize(width: 266, height: 127)
        delegate = self
        dataSource = self
        register(AnAnSearchHPDItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchHPDItemCollectionViewCell")
        backgroundColor = .white
        contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnSearchPDCollectionview:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchHPDItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchHPDItemCollectionViewCell", for: indexPath) as! AnAnSearchHPDItemCollectionViewCell
        return cell
    }
    
}
