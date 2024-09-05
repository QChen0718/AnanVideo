//
//  AnAnHotSheetCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/23.
//  热门片单

import UIKit

class AnAnHotSheetCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangSemiboldWithSize(fontSize: 17))
        return label
    }()
    
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 161, height: 161)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var albumCollectionView:AnAnVideoAlbumCollectionView = {
        let collectionView = AnAnVideoAlbumCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func createSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(albumCollectionView)
    }
    
    private func setSubviewsFrame() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalToSuperview()
            make.height.equalTo(21)
        }
        
        albumCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.height.equalTo(161)
        }
    }
    
    var dramaAlbumListModel:[DramaAlbumListModel]?{
        didSet{
            albumCollectionView.dramaAlbumListModel = dramaAlbumListModel
        }
    }
    var moduleTitle:String?{
        didSet{
            titleLabel.text = moduleTitle
        }
    }
}
