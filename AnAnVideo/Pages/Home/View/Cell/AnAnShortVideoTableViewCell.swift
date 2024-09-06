//
//  AnAnShortVideoTableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/6.
//

import UIKit

class AnAnShortVideoTableViewCell: UITableViewCell {

    lazy var shortVideoCollection:AnAnShortVideoCollectionView = {
        let view = AnAnShortVideoCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.contentView.addSubview(shortVideoCollection)
        shortVideoCollection.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
            make.height.equalTo(292)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sectionContentModels:[SectionContentModel]?{
        didSet{
            shortVideoCollection.sectionContentModels = sectionContentModels
        }
    }
    
}
