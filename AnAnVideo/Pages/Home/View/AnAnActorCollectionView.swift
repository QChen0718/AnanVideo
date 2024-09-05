//
//  AnAnActorCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/17.
//

import UIKit

class AnAnActorCollectionView: UICollectionView {
    
    let anAnHomeActorCollectionViewCellId = "AnAnHomeActorCollectionViewCellId"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.showsHorizontalScrollIndicator = false
        self.register(AnAnHomeActorCollectionViewCell.self, forCellWithReuseIdentifier: anAnHomeActorCollectionViewCellId)
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

extension AnAnActorCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionContentModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnHomeActorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnHomeActorCollectionViewCellId, for: indexPath) as! AnAnHomeActorCollectionViewCell
        cell.sectionContentModel = sectionContentModels?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionContentModel = sectionContentModels?[indexPath.row]
        AnAnJumpPageManager.gotToDetailPage(dramaId: sectionContentModel?.dramaId ?? "")
    }
}
