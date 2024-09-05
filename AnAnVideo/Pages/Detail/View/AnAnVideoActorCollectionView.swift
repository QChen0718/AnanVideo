//
//  AnAnVideoActorCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/26.
//

import UIKit

class AnAnVideoActorCollectionView: UICollectionView {

    fileprivate let anAnVideoActorItemCollectionViewCellId = "AnAnVideoActorItemCollectionViewCellId"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.showsHorizontalScrollIndicator = false
        self.register(AnAnVideoActorItemCollectionViewCell.self, forCellWithReuseIdentifier: anAnVideoActorItemCollectionViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var actorList:[ActorListModel]?{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnVideoActorCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnVideoActorItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnVideoActorItemCollectionViewCellId, for: indexPath) as! AnAnVideoActorItemCollectionViewCell
        cell.actorListModel = actorList?[indexPath.row]
        return cell
    }
    
    
}
