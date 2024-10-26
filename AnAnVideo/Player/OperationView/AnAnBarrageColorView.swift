//
//  AnAnBarrageColorView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/27.
//  设置发送弹幕颜色视图

import UIKit

class AnAnBarrageColorView: UIView {

    let colors:[String] = [An_E6E7E8,An_00F760,An_EFF531,An_FB4273,An_D777FE]
    
    lazy var titleLab:UILabel = {
       let lab = UILabel()
        lab.text = "弹幕颜色"
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.6)
        lab.font = .systemFont(ofSize: 12, weight: .semibold)
        return lab
    }()
    
    lazy var colorCollectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 30, height: 30)
        flowLayout.minimumLineSpacing = 24
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(AnAnBarrageColorItemCell.self, forCellWithReuseIdentifier: AnAnBarrageColorItemCell.description())
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_1F2126)
        addSubview(titleLab)
        addSubview(colorCollectionView)
        titleLab.snp.makeConstraints { make in
            make.leading.equalTo(40)
            make.top.equalTo(20)
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnBarrageColorView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnBarrageColorItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnAnBarrageColorItemCell.description(), for: indexPath) as! AnAnBarrageColorItemCell
        cell.colorName = colors[indexPath.row]
        return cell
    }
}
