//
//  AnAnPeriodCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/23.
//  选季

import UIKit

class AnAnPeriodCollectionView: UICollectionView {

    fileprivate let anAnPeriodItemCollectionViewCellId = "AnAnPeriodItemCollectionViewCellId"
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.showsHorizontalScrollIndicator = false
        self.register(AnAnPeriodItemCollectionViewCell.self, forCellWithReuseIdentifier: anAnPeriodItemCollectionViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var dramaSeriesList:[DramaSeriesListModel]?{
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnPeriodCollectionView:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dramaSeriesList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:AnAnPeriodItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnPeriodItemCollectionViewCellId, for: indexPath) as! AnAnPeriodItemCollectionViewCell
        cell.sectionModel = dramaSeriesList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var seriesList = dramaSeriesList else { return }
        for i in 0..<seriesList.count{
            seriesList[i].isCurPlay = false
        }
        dramaSeriesList = seriesList
        dramaSeriesList?[indexPath.row].isCurPlay = true
        reloadData()
    }
}
