//
//  AnAnFilterCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnFilterCollectionView: UICollectionView {

    var filterArray:[String]?{
        didSet {
//            赋值更新
            self.reloadData()
        }
    }
    
    let anAnFilterItemCollectionViewCellId = "AnAnFilterItemCollectionViewCellId"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false
        self.register(AnAnFilterItemCollectionViewCell.self, forCellWithReuseIdentifier: anAnFilterItemCollectionViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var typeTags:[AnAnFilterItemModel]?{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnFilterCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeTags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnFilterItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnFilterItemCollectionViewCellId, for: indexPath) as! AnAnFilterItemCollectionViewCell
        cell.filterName = typeTags?[indexPath.row].displayName
        cell.indexPath = indexPath
        return cell
    }
//  自适应cell大小的时候需要设置
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.01, height: 30)
    }
}
