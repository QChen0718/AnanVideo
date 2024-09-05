//
//  AnAnEpisodeSectionCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/13.
//

import UIKit

class AnAnEpisodeSectionCollectionView: UICollectionView {

    private let anAnEpisodeSectionItemCollectionViewCellId = "AnAnEpisodeSectionItemCollectionViewCellId"
    
    private var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
  
    init() {
        super.init(frame: .zero, collectionViewLayout: viewLayout)
        delegate = self
        dataSource = self
        contentInset = UIEdgeInsets(top: 20, left: 18, bottom: 20, right: 18)
        register(AnAnEpisodeSectionItemCollectionViewCell.self, forCellWithReuseIdentifier: anAnEpisodeSectionItemCollectionViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnEpisodeSectionCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnEpisodeSectionItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnEpisodeSectionItemCollectionViewCellId, for: indexPath) as! AnAnEpisodeSectionItemCollectionViewCell
        
        return cell
    }
}
