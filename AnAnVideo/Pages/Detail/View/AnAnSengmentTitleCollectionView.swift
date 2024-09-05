//
//  AnAnSengmentTitleCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/20.
//

import UIKit

typealias SelectCellIndexBlock = (Int)->Void

class AnAnSengmentTitleCollectionView: UICollectionView {

    let anAnSengmentTitleCollectionViewCellId = "AnAnSengmentTitleCollectionViewCellId"
    
    fileprivate lazy var titlesArray:[String] = {
        let array = ["详情","讨论","影评"]
        return array
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.register(AnAnSengmentTitleCollectionViewCell.self, forCellWithReuseIdentifier: anAnSengmentTitleCollectionViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectIndex:Int = 0{
        didSet{
            self.reloadData()
        }
    }
    
    var selectIndexBlock:SelectCellIndexBlock?
}

extension AnAnSengmentTitleCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnSengmentTitleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnSengmentTitleCollectionViewCellId, for: indexPath) as! AnAnSengmentTitleCollectionViewCell
        cell.titleStr = titlesArray[indexPath.row]
        if selectIndex == indexPath.row{
            cell.isSelectSegmentTitle = true
        }else{
            cell.isSelectSegmentTitle = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == selectIndex{
            return
        }
        selectIndex = indexPath.row
        selectIndexBlock!(indexPath.row)
        self.reloadData()
    }
}
