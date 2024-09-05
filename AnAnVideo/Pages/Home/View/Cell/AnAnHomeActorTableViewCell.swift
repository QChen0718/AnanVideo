//
//  AnAnHomeActorTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/17.
//

import UIKit

class AnAnHomeActorTableViewCell: UITableViewCell {
    
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 110, height: 120)
        return layout
    }()
    
    private lazy var actorCollectionView:AnAnActorCollectionView = {
        let collectionView = AnAnActorCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubviews()
        setSubviewsFrame()
    }
    var sectionContentModels:[SectionContentModel]?{
        didSet{
            self.actorCollectionView.sectionContentModels = sectionContentModels
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        contentView.addSubview(actorCollectionView)
    }
    
    private func setSubviewsFrame() {
        actorCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
            make.bottom.equalToSuperview()
        }
    }
}
