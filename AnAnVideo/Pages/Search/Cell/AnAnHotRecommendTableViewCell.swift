//
//  AnAnHotRecommendTableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnHotRecommendTableViewCell: UITableViewCell {
    lazy var searchCollection:AnAnSearchCollectionview = {
        let view = AnAnSearchCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    lazy var pageControll: UIPageViewController = {
        let view = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        contentView.addSubview(searchCollection)
        searchCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
