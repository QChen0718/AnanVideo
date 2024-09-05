//
//  AnAnMAGICCUBETableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/5.
//

import UIKit

class AnAnMAGICCUBETableViewCell: UITableViewCell {

    lazy var mfCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:floor((AnAnAppDevice.an_screenWidth()-160)/4.0), height: 60)
        layout.minimumLineSpacing = 40
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white;
        view.delegate = self
        view.dataSource = self
        view.contentInsetAdjustmentBehavior = .never
        view.register(AnAnCUBECollectionViewCell.self, forCellWithReuseIdentifier: AnAnCUBECollectionViewCell.description())
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none;
        self.backgroundColor = .white;
        self.contentView.addSubview(self.mfCollectionView)
        self.mfCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
            make.height.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var sectionContentModels:[SectionContentModel]?{
        didSet{
            mfCollectionView.reloadData()
        }
    }
    
}

extension AnAnMAGICCUBETableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionContentModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnCUBECollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnAnCUBECollectionViewCell.description(), for: indexPath) as! AnAnCUBECollectionViewCell
        cell.sectionContentModel = self.sectionContentModels?[indexPath.row]
        return cell
    }
}
