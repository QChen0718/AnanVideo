//
//  AnAnVideoAlbumCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/26.
//

import UIKit

class AnAnVideoAlbumCollectionView: UICollectionView {

    fileprivate let anAnAlbumItemCollectionViewCellId = "AnAnAlbumItemCollectionViewCellId"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.showsHorizontalScrollIndicator = false
        self.register(AnAnAlbumItemCollectionViewCell.self, forCellWithReuseIdentifier: anAnAlbumItemCollectionViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var dramaAlbumListModel:[DramaAlbumListModel]?{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnVideoAlbumCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dramaAlbumListModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnAlbumItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnAlbumItemCollectionViewCellId, for: indexPath) as! AnAnAlbumItemCollectionViewCell
        cell.dramaAlbumModel = dramaAlbumListModel![indexPath.row]
        return cell
    }
    
}
