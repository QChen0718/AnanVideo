//
//  AnAnSearchResultTableview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchResultCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(AnAnSearchVideoItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchVideoItemCollectionViewCell")
        register(AnAnSearchPDCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchPDCollectionViewCell")
        register(AnAnSearchShortVideoItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchShortVideoItemCollectionViewCell")
        backgroundColor = .white
        contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnSearchResultCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:AnAnSearchVideoItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchVideoItemCollectionViewCell", for: indexPath) as! AnAnSearchVideoItemCollectionViewCell
            return cell
        }else if indexPath.section == 1 {
            let cell:AnAnSearchPDCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchPDCollectionViewCell", for: indexPath) as! AnAnSearchPDCollectionViewCell
            return cell
        }
        else{
            let cell:AnAnSearchShortVideoItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchShortVideoItemCollectionViewCell", for: indexPath) as! AnAnSearchShortVideoItemCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 65)
        }else if indexPath.section == 1 {
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 127)
        }else{
            return CGSize(width: floor((AnAnAppDevice.an_screenWidth()-40)/2), height: 178)
        }
    }
}
