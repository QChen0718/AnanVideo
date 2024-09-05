//
//  AnAnHomeRecommentTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/27.
//

import UIKit

class AnAnHomeRecommentTableViewCell: UITableViewCell {

    private lazy var layout:UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15.5
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 105, height: 183)
        return layout
    }()
    
    private lazy var morePhotoView:AnAnMorePhotoCollectionView = {
        let collectionView:AnAnMorePhotoCollectionView = AnAnMorePhotoCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView;
    }()
    
    
    var sectionContentModels:[SectionContentModel]?{
        didSet{
            self.morePhotoView.sectionContentModels = sectionContentModels
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(morePhotoView)
        morePhotoView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(394)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
