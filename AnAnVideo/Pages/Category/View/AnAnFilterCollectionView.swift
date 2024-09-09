//
//  AnAnFilterCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnFilterCollectionView: UICollectionView {
    
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
        cell.model = typeTags?[indexPath.row]
        return cell
    }
//  自适应cell大小的时候需要设置
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.01, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let `filterArray` = typeTags else { return }
        for (index,_) in filterArray.enumerated(){
            typeTags?[index].isSelect = false
        }
        typeTags?[indexPath.row].isSelect = true
        self.reloadData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "notification.updateCategoryListData"), object: nil)
    }
}
