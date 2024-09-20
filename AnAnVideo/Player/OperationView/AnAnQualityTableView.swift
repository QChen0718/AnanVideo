//
//  AnAnQualityTableView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//

import UIKit

typealias CurrentSelectQualityBlock = (SortedItemModel?)->Void

class AnAnQualityTableView: UITableView {

    fileprivate let anAnQualityTableViewCellId = "AnAnQualityTableViewCellId"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        backgroundColor = .clear
        separatorStyle = .none
        self.register(AnAnQualityTableViewCell.self, forCellReuseIdentifier: anAnQualityTableViewCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectIndex:Int = 0{
        didSet{
            self.reloadData()
        }
    }
    
    var qualityArray:[SortedItemModel]?{
        didSet{
            self.reloadData()
        }
    }
    
    var currentQualityBlock:CurrentSelectQualityBlock?
}

extension AnAnQualityTableView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qualityArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnAnQualityTableViewCell = tableView.dequeueReusableCell(withIdentifier: anAnQualityTableViewCellId) as! AnAnQualityTableViewCell
        if selectIndex == indexPath.row{
            cell.isSelectIndex = true
        }else{
            cell.isSelectIndex = false
        }
        cell.huaZhiInfoModel = qualityArray?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == selectIndex {
            return
        }
        selectIndex = indexPath.row
        currentQualityBlock?(qualityArray?[indexPath.row])
        self.reloadData()
    }
}
