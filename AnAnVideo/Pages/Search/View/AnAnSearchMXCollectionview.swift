//
//  AnAnSearchMXCollectionview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchMXCollectionview: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        guard let flowlayout = layout as? UICollectionViewFlowLayout else { return }
        flowlayout.minimumLineSpacing = 8
        flowlayout.itemSize = CGSize(width: AnAnAppDevice.an_screenWidth(), height: 80)
        delegate = self
        dataSource = self
        register(AnAnSearchActorItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnSearchActorItemCollectionViewCell")
        contentInsetAdjustmentBehavior = .never
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AnAnSearchMXCollectionview:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSearchActorItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnSearchActorItemCollectionViewCell", for: indexPath) as! AnAnSearchActorItemCollectionViewCell
        return cell
    }
}
