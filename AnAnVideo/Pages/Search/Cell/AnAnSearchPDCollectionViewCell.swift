//
//  AnAnSearchPDCollectionViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/18.
//

import UIKit

class AnAnSearchPDCollectionViewCell: UICollectionViewCell {
    
    lazy var pdcollection:AnAnSearchPDCollectionview = {
        let view = AnAnSearchPDCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(pdcollection)
        pdcollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
