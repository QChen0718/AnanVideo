//
//  AnAnSearchVPDViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchVPDCollectionview: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        guard let flowlayout = layout as? UICollectionViewFlowLayout else { return }
        flowlayout.minimumLineSpacing = 8
        flowlayout.minimumInteritemSpacing = 8
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowlayout.itemSize = CGSize(width: floor((AnAnAppDevice.an_screenWidth()-40)/2), height: 208)
        delegate = self
        dataSource = self
        register(AnAnSearchPDItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchPDItemCollectionViewCell")
        contentInsetAdjustmentBehavior = .never
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnSearchVPDCollectionview:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchPDItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchPDItemCollectionViewCell", for: indexPath) as! AnAnSearchPDItemCollectionViewCell
        return cell
    }
}
