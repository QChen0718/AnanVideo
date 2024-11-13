//
//  AnAnPageTitleCollectionview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnPageTitleCollectionview: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        guard let flowlayout = layout as? UICollectionViewFlowLayout else { return }
        flowlayout.minimumLineSpacing = 21
        flowlayout.minimumInteritemSpacing = 21
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowlayout.scrollDirection = .horizontal
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        delegate = self
        dataSource = self
        contentInsetAdjustmentBehavior = .never
        backgroundColor = .white
        register(AnAnPageTitleItemCollectionViewCell.self, forCellWithReuseIdentifier: "AnAnPageTitleItemCollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataList:[AnAnHotModel?]?{
        didSet{
            self.reloadData()
        }
    }
}


extension AnAnPageTitleCollectionview:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnPageTitleItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnAnPageTitleItemCollectionViewCell", for: indexPath) as! AnAnPageTitleItemCollectionViewCell
        cell.hotModel = dataList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.1, height: 21)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataList?.forEach({ model in
            model?.isSelect = false
        })
        
        let curmodel = dataList?[indexPath.row]
        curmodel?.isSelect = true
        NotificationCenter.default.post(name: NSNotification.Name("updateSearchTable"), object: nil, userInfo: ["selectIndex":indexPath.row])
    }
}
