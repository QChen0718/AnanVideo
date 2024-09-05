//
//  AnAnHorizontalCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/27.
//

import UIKit

class AnAnHorizontalCollectionView: UICollectionView {

    let cellId = "AnAnHorizontalCollectionViewCellId"
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.showsHorizontalScrollIndicator = false
        self.register(AnAnHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var sectionContentModels:[SectionContentModel]?{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnHorizontalCollectionView:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionContentModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnHorizontalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnAnHorizontalCollectionViewCell
        cell.sectionContentModel = self.sectionContentModels?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionContentModel = sectionContentModels?[indexPath.row]
        AnAnJumpPageManager.gotToDetailPage(dramaId: sectionContentModel?.dramaId ?? "")
    }
}

