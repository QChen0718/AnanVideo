//
//  AnAnSearchActorCollectionview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/20.
//

import UIKit

class AnAnSearchActorCollectionview: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        guard let flowlayout = layout as? UICollectionViewFlowLayout else { return  }
        flowlayout.scrollDirection = .horizontal
        flowlayout.minimumLineSpacing = 8
        flowlayout.minimumInteritemSpacing = 8
        flowlayout.itemSize = CGSize(width: 100, height: 183)
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        delegate = self
        dataSource = self
        contentInsetAdjustmentBehavior = .never
        backgroundColor = .white
        register(AnAnSearchItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchItemCollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var recommentDramaList:[AnAnRelatedDramaModel] = []{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnSearchActorCollectionview:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommentDramaList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchItemCollectionViewCell", for: indexPath) as! AnAnSearchItemCollectionViewCell
        cell.dramaModel = recommentDramaList[indexPath.row]
        return cell
    }
}
