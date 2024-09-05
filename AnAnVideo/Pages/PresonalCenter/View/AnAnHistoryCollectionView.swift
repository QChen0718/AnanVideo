//
//  AnAnHistoryCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/9.
//

import UIKit

class AnAnHistoryCollectionView: UICollectionView {
    let anAnHistoryItemCollectionViewCellId = "AnAnHistoryItemCollectionViewCellId"
    let anAnHistoryMoreCollectionViewCellId = "AnAnHistoryMoreCollectionViewCellId"
    private lazy var sectionArray:[String] = {
        let array = [anAnHistoryItemCollectionViewCellId,anAnHistoryMoreCollectionViewCellId]
        return array
    }()
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.register(AnAnHistoryItemCollectionViewCell.self, forCellWithReuseIdentifier: anAnHistoryItemCollectionViewCellId)
        self.register(AnAnHistoryMoreCollectionViewCell.self, forCellWithReuseIdentifier: anAnHistoryMoreCollectionViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnHistoryCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = sectionArray[indexPath.section]
        if cellType == anAnHistoryItemCollectionViewCellId{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnHistoryItemCollectionViewCellId, for: indexPath) as! AnAnHistoryItemCollectionViewCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnHistoryMoreCollectionViewCellId, for: indexPath) as! AnAnHistoryMoreCollectionViewCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (AnAnAppDevice.an_screenWidth()-60)/3
        let cellType = sectionArray[indexPath.section]
        if cellType == anAnHistoryItemCollectionViewCellId{
            return CGSize(width: width, height: width * 105/80.5)
        }else{
            return CGSize(width: 60, height: 79)
        }
    }
}
