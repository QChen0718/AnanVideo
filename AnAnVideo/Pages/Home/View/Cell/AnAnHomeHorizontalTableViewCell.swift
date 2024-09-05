//
//  AnAnHomeHorizontalTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/27.
//

import UIKit

class AnAnHomeHorizontalTableViewCell: UITableViewCell {

    lazy var layout:UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 162, height: 211)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var horizontalCollectionView:AnAnHorizontalCollectionView = {
        let collectionView = AnAnHorizontalCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    var sectionContentModels:[SectionContentModel]?{
        didSet{
            self.horizontalCollectionView.sectionContentModels = sectionContentModels
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView .addSubview(horizontalCollectionView)
        horizontalCollectionView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(211)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
