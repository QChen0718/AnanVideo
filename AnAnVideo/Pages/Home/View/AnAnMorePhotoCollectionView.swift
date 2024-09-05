//
//  AnAnMorePhotoCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/27.
//

import UIKit

class AnAnMorePhotoCollectionView: UICollectionView {

    let cellId = "AnAnMorePhotoCollectionViewCellId"
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 14, right: 20)
        self.register(AnAnMorePhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.isScrollEnabled = false
    }
    
    var sectionContentModels:[SectionContentModel]?{
        didSet{
            self.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnMorePhotoCollectionView:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionContentModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnMorePhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnAnMorePhotoCollectionViewCell
        cell.sectionContentModel = self.sectionContentModels?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionContentModel = sectionContentModels?[indexPath.row]
        AnAnJumpPageManager.gotToDetailPage(dramaId: sectionContentModel?.dramaId ?? "")
    }
}
